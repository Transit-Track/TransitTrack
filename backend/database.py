import motor.motor_asyncio

# Configuration
DATABASE_URL = "mongodb+srv://transit_track:transit1234@transittrack.ax0pf.mongodb.net/?retryWrites=true&w=majority&appName=transittrack"
client = motor.motor_asyncio.AsyncIOMotorClient(DATABASE_URL)
db = client.auth_demo
