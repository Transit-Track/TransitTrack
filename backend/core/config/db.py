from motor.motor_asyncio import AsyncIOMotorClient

uri = "mongodb+srv://tmel67763:DVbOJAHPYTZwvv4U@cluster0.owvt1.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"
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