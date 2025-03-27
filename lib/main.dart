import 'package:flutter/material.dart';
import 'services/mongodb_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MongoDB Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: const MongoDBTestScreen(),
    );
  }
}

class MongoDBTestScreen extends StatefulWidget {
  const MongoDBTestScreen({super.key});

  @override
  State<MongoDBTestScreen> createState() => _MongoDBTestScreenState();
}

class _MongoDBTestScreenState extends State<MongoDBTestScreen> {
  String _status = 'Not connected';
  bool _isLoading = false;
  List<Map<String, dynamic>> _documents = [];

  Future<void> _testConnection() async {
    setState(() {
      _isLoading = true;
      _status = 'Connecting to MongoDB...';
    });

    try {
      await MongoDBService.connect();
      
      // Try to insert a test document
      await MongoDBService.insertDocument({
        'timestamp': DateTime.now().toString(),
        'message': 'Test connection successful'
      });

      // Try to fetch documents
      final docs = await MongoDBService.getAllDocuments();
      
      setState(() {
        _status = 'Connected successfully!';
        _documents = docs;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _status = 'Error: $e';
        _isLoading = false;
      });
      print('Connection error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MongoDB Connection Test'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _isLoading ? null : _testConnection,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Test MongoDB Connection', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  const Text(
                    'Status:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _status,
                    style: TextStyle(
                      fontSize: 16,
                      color: _status.contains('Error')
                          ? Colors.red
                          : _status.contains('Connected successfully')
                              ? Colors.green
                              : Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            if (_documents.isNotEmpty) ...[
              const SizedBox(height: 24),
              const Text(
                'Stored Documents:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: _documents.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(_documents[index].toString()),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    MongoDBService.close();
    super.dispose();
  }
} 