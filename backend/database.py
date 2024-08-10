import motor.motor_asyncio

# Configuration
DATABASE_URL = "mongodb://localhost:27017"
client = motor.motor_asyncio.AsyncIOMotorClient(DATABASE_URL)
db = client.auth_demo
