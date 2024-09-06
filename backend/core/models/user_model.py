from pydantic import BaseModel, EmailStr
from typing import Optional

class User(BaseModel):
    full_name: str
    phone_number: str
    email: Optional[EmailStr]
    hashed_password: bytes
    role:str
    image_url: Optional[str]

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
    
class UserUpdate(BaseModel):
    full_name: str
    phone_number: str
    email: Optional[EmailStr]
    password: str
    image_url: Optional[str]

class Token(BaseModel):
    access_token: str
    token_type: str

class LoginRequest(BaseModel):
    phone_number: str
    password: str
    
