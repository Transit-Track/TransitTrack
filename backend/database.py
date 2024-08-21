import motor.motor_asyncio
from pymongo.errors import ConnectionFailure

# Configuration
DATABASE_URL = "mongodb://localhost:27017"

try:
    client = motor.motor_asyncio.AsyncIOMotorClient(DATABASE_URL)
    db = client.auth_demo
    # Test the connection
    client.admin.command('ping')
    print("Connected to MongoDB successfully!")
except ConnectionFailure as e:
    print(f"Could not connect to MongoDB: {e}")
