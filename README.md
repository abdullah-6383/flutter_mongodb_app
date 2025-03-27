# Flutter MongoDB App

A Flutter application with MongoDB Atlas integration, designed for Android devices. The application uses a FastAPI backend to handle data operations with MongoDB Atlas.

## Project Structure

```
flutter_mongodb_app/
├── android/         # Android-specific files
├── lib/            # Flutter application code
│   ├── main.dart   # Main application entry
│   └── services/   # Services for MongoDB integration
└── backend/        # FastAPI backend
    ├── main.py     # FastAPI server
    └── requirements.txt
```

## Setup Instructions

### Backend Setup

1. Navigate to the backend directory:
   ```bash
   cd backend
   ```
2. Install Python dependencies:
   ```bash
   pip install -r requirements.txt
   ```
3. Start the FastAPI server:
   ```bash
   uvicorn main:app --reload
   ```

### Flutter App Setup

1. Navigate to the Flutter app directory:
   ```bash
   cd flutter_mongodb_app
   ```
2. Get Flutter dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## Features

- Clean, minimal Flutter application structure
- MongoDB Atlas integration through FastAPI backend
- Android-optimized user interface

## Requirements

- Flutter SDK
- Android Studio/SDK
- Python 3.7+
- MongoDB Atlas account
