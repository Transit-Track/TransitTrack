from datetime import datetime, timedelta
from typing import Optional
import bcrypt
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from fastapi import HTTPException, status
from jose import JWTError, jwt
from core.config.db import client as db
class UserRepository:
    SECRET_KEY = "your_secret_key"
    ALGORITHM = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES = 30
    
    def __init__(self) -> None:
        self.db = db.local.transittrack.users
    
    
    async def add_user(self, user_dict):
        user_in_db = await self.get_user_by_phone(user_dict['phone_number'])
        if user_in_db:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Phone number already registered"
            )
        if user_dict['role'] == 'driver':    
            result = await self.db.drivers.insert_one(user_dict)
        elif user_dict['role'] == 'conductor':
            result = await self.db.conductors.insert_one(user_dict)
        else:            
            result = await self.db.commuters.insert_one(user_dict)
        user_dict["id"] = str(result.inserted_id)
        
        return user_dict

    async def update_user(self, user_dict, token):
        user = await self.read_users_me(token)
        if user['role'] == 'driver':
            updated_user = await self.db.drivers.update_one({"phone_number": user['phone_number']}, {"$set": user_dict})
        elif user['role'] == 'conductor':
            updated_user = await self.db.conductors.update_one({"phone_number": user['phone_number']}, {"$set": user_dict})
        else:
            updated_user = await self.db.commuters.update_one({"phone_number": user['phone_number']}, {"$set": user_dict})
        if updated_user:
            return user_dict
        return
    
    async def get_user_by_phone(self,phone_number: str):
        user = await self.db.commuters.find_one({"phone_number": phone_number})
        user = user or await self.db.drivers.find_one({"phone_number": phone_number})
        user = user or await self.db.conductors.find_one({"phone_number": phone_number})

        if user:
            return user
        return False
    
    async def authenticate_user(self,phone_number: str, password: str):
        
        user = await self.get_user_by_phone(phone_number)
        if user and bcrypt.checkpw(password.encode('utf-8'), user['hashed_password']):
            return user
        return False
    
    async def login(self, form_data:OAuth2PasswordRequestForm):
        user = await self.authenticate_user(form_data.phone_number, form_data.password)
        if not user:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Incorrect phone number or password",
                headers={"WWW-Authenticate": "Bearer"},
            )
        access_token_expires = timedelta(minutes=self.ACCESS_TOKEN_EXPIRE_MINUTES)
        access_token = self.create_access_token(
            data={"sub": user['phone_number'], 'role': user['role']}, expires_delta=access_token_expires
        )
        return {"access_token": access_token, "token_type": "bearer"}
    
    def create_access_token(self, data: dict, expires_delta: Optional[timedelta] = None):
        to_encode = data.copy()
        if expires_delta:
            expire = datetime.now() + expires_delta
        else:
            expire = datetime.now() + timedelta(minutes=15)
        to_encode.update({"exp": expire})
        encoded_jwt = jwt.encode(to_encode, self.SECRET_KEY, algorithm=self.ALGORITHM)
        return encoded_jwt

    async def delete_user(self, token):
        user = await self.read_users_me(token)
        if user['role'] == 'driver':
            await self.db.drivers.delete_one({"phone_number": user['phone_number']})
        elif user['role'] == 'conductor':   
            await self.db.conductors.delete_one({"phone_number": user['phone_number']})
        else:
            await self.db.commuters.delete_one({"phone_number": user['phone_number']})
            
        return {"message": "User deleted successfully"} 
    
    async def read_users_me(self, token):
        credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
        )
        try:
            payload = jwt.decode(token, self.SECRET_KEY, algorithms=[self.ALGORITHM])
            phone_number: str = payload.get("sub")
            
        except JWTError:
            raise credentials_exception
        user = await self.get_user_by_phone(phone_number=phone_number)
        if user is None:
            raise credentials_exception
        return user