from motor.motor_asyncio import AsyncIOMotorClient 
from app.core.config import settings

client = AsyncIOMotorClient(settings.MONGODB_URL, tls=True, tlsAllowInvalidCertificates=True) 
database = client[settings.MONGODB_NAME]

def get_database(): 
    return database