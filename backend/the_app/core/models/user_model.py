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
    email: Optional[EmailStr]
    role:str
    image_url: Optional[str]

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
<<<<<<< HEAD:backend/the_app/core/models/user_model.py
    password: str
=======
    password: str
>>>>>>> 9be142d (change database to local):backend/models.py
