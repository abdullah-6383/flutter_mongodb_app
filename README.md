# Flutter MongoDB App

A basic Flutter application with MongoDB Atlas integration.

## Project Structure

```
.
├── backend/             # Python FastAPI backend
│   ├── main.py         # Main FastAPI application
│   └── requirements.txt # Python dependencies
└── flutter_mongodb_app/ # Flutter frontend application
```

## Backend Setup

1. Create a Python virtual environment:

```bash
cd backend
python -m venv venv
```

2. Activate the virtual environment:

- Windows: `.\venv\Scripts\activate`
- Unix/MacOS: `source venv/bin/activate`

3. Install dependencies:

```bash
pip install -r requirements.txt
```

4. Run the FastAPI server:

```bash
python -m uvicorn main:app --host 0.0.0.0 --reload
```

## Frontend Setup

1. Make sure you have Flutter installed and set up.

2. Install dependencies:

```bash
cd flutter_mongodb_app
flutter pub get
```

3. Run the app:

```bash
flutter run
```

## Technologies Used

- Frontend: Flutter
- Backend: Python FastAPI
- Database: MongoDB Atlas
