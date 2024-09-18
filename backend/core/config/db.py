# from motor.motor_asyncio import AsyncIOMotorClient

# client = AsyncIOMotorClient('mongodb://localhost:27017/')
from motor.motor_asyncio import AsyncIOMotorClient
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi

uri = "mongodb+srv://tmel67763:DVbOJAHPYTZwvv4U@cluster0.owvt1.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"

# Create a new client and connect to the server
# client = MongoClient(uri, server_api=ServerApi('1'))
client = AsyncIOMotorClient(uri)
# Send a ping to confirm a successful connection
try:
    client.admin.command('ping')
    print("Pinged your deployment. You successfully connected to MongoDB!")
except Exception as e:
    print('rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr:',e)

