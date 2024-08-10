from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from jose import JWTError, jwt
from datetime import datetime, timedelta
from typing import Optional
import bcrypt

from models import UserCreate, UserInDB, Token
from database import db
from utils import get_user_by_phone, create_access_token, authenticate_user

# Configuration
SECRET_KEY = "your_secret_key"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

router = APIRouter()

@router.post("/signup", response_model=UserInDB)
async def signup(user: UserCreate):
    user_in_db = await get_user_by_phone(user.phone_number)
    if user_in_db:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Phone number already registered"
        )
    hashed_password = bcrypt.hashpw(user.password.encode('utf-8'), bcrypt.gensalt())
    user_dict = {
        "full_name": user.full_name,
        "phone_number": user.phone_number,
        "email": user.email,
        "hashed_password": hashed_password.decode('utf-8')
    }
    result = await db.users.insert_one(user_dict)
    user_dict["id"] = str(result.inserted_id)  # Convert inserted_id to string and assign to id
    return UserInDB(**user_dict)

@router.post("/token", response_model=Token)
async def login_for_access_token(form_data: OAuth2PasswordRequestForm = Depends()):
    user = await authenticate_user(form_data.username, form_data.password)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect phone number or password",
            headers={"WWW-Authenticate": "Bearer"},
        )
    access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(
        data={"sub": user.phone_number}, expires_delta=access_token_expires
    )
    return {"access_token": access_token, "token_type": "bearer"}

@router.post("/change-password")
async def change_password(phone_number: str, old_password: str, new_password: str, token: str = Depends(oauth2_scheme)):
    user = await authenticate_user(phone_number, old_password)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect phone number or old password",
        )
    new_hashed_password = bcrypt.hashpw(new_password.encode('utf-8'), bcrypt.gensalt())
    await db.users.update_one({"phone_number": phone_number}, {"$set": {"hashed_password": new_hashed_password.decode('utf-8')}})
    return {"message": "Password updated successfully"}

@router.delete("/delete-account")
async def delete_account(phone_number: str, token: str = Depends(oauth2_scheme)):
    user = await get_user_by_phone(phone_number)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="User not found",
        )
    await db.users.delete_one({"phone_number": phone_number})
    return {"message": "User deleted successfully"}

@router.get("/users/me/", response_model=UserInDB)
async def read_users_me(token: str = Depends(oauth2_scheme)):
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        phone_number: str = payload.get("sub")
        if phone_number is None:
            raise credentials_exception
    except JWTError:
        raise credentials_exception
    user = await get_user_by_phone(phone_number=phone_number)
    if user is None:
        raise credentials_exception
    return user
