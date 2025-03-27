from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pymongo import MongoClient
from bson import ObjectId
from datetime import datetime
from pydantic import BaseModel
from typing import List, Optional
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

app = FastAPI(title="Flutter MongoDB Backend")

# Enable CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # In production, replace with your Flutter app's domain
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# MongoDB connection
MONGO_URI = os.getenv("MONGO_URI", "mongodb+srv://mohammedabd6383:Abdullah%406383@giggity.aroykgg.mongodb.net/?retryWrites=true&w=majority&appName=Giggity")
client = MongoClient(MONGO_URI)
db = client.flutter_app_db
collection = db.items

# Pydantic models
class Item(BaseModel):
    title: str
    description: Optional[str] = None
    completed: bool = False

class ItemResponse(Item):
    id: str
    created_at: str

@app.get("/")
async def read_root():
    return {"message": "Welcome to the Flutter MongoDB Backend"}

@app.get("/items", response_model=List[ItemResponse])
async def get_items():
    items = []
    for item in collection.find():
        items.append({
            "id": str(item["_id"]),
            "title": item["title"],
            "description": item.get("description"),
            "completed": item.get("completed", False),
            "created_at": item.get("created_at", datetime.now().isoformat())
        })
    return items

@app.post("/items", response_model=ItemResponse)
async def create_item(item: Item):
    item_dict = item.dict()
    item_dict["created_at"] = datetime.now().isoformat()
    result = collection.insert_one(item_dict)
    created_item = collection.find_one({"_id": result.inserted_id})
    return {
        "id": str(created_item["_id"]),
        **item.dict(),
        "created_at": created_item["created_at"]
    }

@app.put("/items/{item_id}")
async def update_item(item_id: str, item: Item):
    result = collection.update_one(
        {"_id": ObjectId(item_id)},
        {"$set": item.dict()}
    )
    if result.modified_count == 0:
        raise HTTPException(status_code=404, detail="Item not found")
    return {"message": "Item updated successfully"}

@app.delete("/items/{item_id}")
async def delete_item(item_id: str):
    result = collection.delete_one({"_id": ObjectId(item_id)})
    if result.deleted_count == 0:
        raise HTTPException(status_code=404, detail="Item not found")
    return {"message": "Item deleted successfully"} 