from datetime import datetime, timedelta
from typing import Optional
import bcrypt
from jose import jwt

from models import UserInDB
from database import db

# Configuration
SECRET_KEY = "your_secret_key"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30

async def get_user_by_phone(phone_number: str):
    user = await db.users.find_one({"phone_number": phone_number})
    if user:
        user["id"] = str(user["_id"])  # Convert _id to string and assign to id
        return UserInDB(**user)
    return None

async def authenticate_user(phone_number: str, password: str):
    user = await get_user_by_phone(phone_number)
    if user and bcrypt.checkpw(password.encode('utf-8'), user.hashed_password.encode('utf-8')):
        return user
    return False

def create_access_token(data: dict, expires_delta: Optional[timedelta] = None):
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=15)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt
