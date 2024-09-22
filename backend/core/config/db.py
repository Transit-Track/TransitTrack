from motor.motor_asyncio import AsyncIOMotorClient

# Use the correct MongoDB URI
uri = "mongodb://localhost:27017"

# Create a new client and connect to the local MongoDB server
client = AsyncIOMotorClient(uri)
db = client["transit-track"]

transactions_collection = db["transactions"]
tickets_collection = db["tickets"]
buses_collection = db["buses"]
users_collection = db["users"]

# Send a ping to confirm a successful connection
try:
    client.admin.command('ping')
    print("Pinged your MongoDB. You successfully connected!")
except Exception as e:
    print('Connection error:', e)
