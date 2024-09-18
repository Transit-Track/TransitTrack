from motor.motor_asyncio import AsyncIOMotorClient

MONGODB_URL: str = "mongodb+srv://WizardTi:75YUkDYZp4aYITFP@cluster0.rfbjo.mongodb.net/"
MONGODB_NAME: str = "payment_db"
client = AsyncIOMotorClient(MONGODB_URL, tls=True, tlsAllowInvalidCertificates=True)
database = client[MONGODB_NAME]

transactions_collection = database["transactions"]
tickets_collection = database["tickets"]
buses_collection = database["buses"]
users_collection = database["users"]

def get_database():
    return database