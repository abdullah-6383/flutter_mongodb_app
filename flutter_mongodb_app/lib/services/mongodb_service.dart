import 'package:mongo_dart/mongo_dart.dart';

class MongoDBService {
  static late Db _db;
  static late DbCollection _collection;
  
  // MongoDB Atlas credentials with encoded password
  static const String _connectionString = 'mongodb+srv://mohammedabd6383:Abdullah%406383@giggity.aroykgg.mongodb.net/?retryWrites=true&w=majority&appName=Giggity';
  static const String _dbName = 'flutter_app_db';
  static const String _collectionName = 'items';

  static Future<void> connect() async {
    try {
      _db = await Db.create(_connectionString);
      await _db.open();
      print('Connected to MongoDB Atlas');
      
      _collection = _db.collection(_collectionName);
    } catch (e) {
      print('Error connecting to MongoDB: $e');
      rethrow;
    }
  }

  static Future<void> close() async {
    await _db.close();
  }

  static Future<List<Map<String, dynamic>>> getAllDocuments() async {
    try {
      final documents = await _collection.find().toList();
      return documents;
    } catch (e) {
      print('Error fetching documents: $e');
      rethrow;
    }
  }

  static Future<void> insertDocument(Map<String, dynamic> document) async {
    try {
      await _collection.insert(document);
    } catch (e) {
      print('Error inserting document: $e');
      rethrow;
    }
  }
} 