from pydantic import BaseModel, EmailStr
from typing import Optional
from bson import ObjectId
from validator import PyObjectId



class User(BaseModel):
    full_name: str
    phone_number: str
    email: Optional[EmailStr]
    hashed_password: bytes
    role:str
    image_url: Optional[str]
    payment_transaction: Optional[PyObjectId] = None

class UserOut(BaseModel):
    full_name: str
    phone_number: str
    email: Optional[EmailStr]  = None
    role:str
    image_url: Optional[str] = None

class UserInDB(BaseModel):
    id: str

class UserCreate(BaseModel):
    full_name: str
    phone_number: str
    email: Optional[EmailStr]
    password: str

class Token(BaseModel):
    access_token: str
    token_type: str

class LoginRequest(BaseModel):
    phone_number: str
    password: str