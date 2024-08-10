from pydantic import BaseModel, EmailStr
from typing import Optional

class User(BaseModel):
    full_name: str
    phone_number: str
    email: Optional[EmailStr]
    hashed_password: str

class UserInDB(User):
    id: str

class UserCreate(BaseModel):
    full_name: str
    phone_number: str
    email: Optional[EmailStr]
    password: str

class Token(BaseModel):
    access_token: str
    token_type: str
