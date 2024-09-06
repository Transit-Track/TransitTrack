import bcrypt
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from features.auth.repositories.user_repo import UserRepository
from core.models.user_model import *

class UserService:
    def __init__(self, user_repo:UserRepository) -> None:
        self.user_repo = user_repo
    
    async def signup(self, user:UserCreate) -> UserInDB:
        user_dict = user.model_dump()
        hashed_password = bcrypt.hashpw(user.password.encode('utf-8'), bcrypt.gensalt())
        print(type(hashed_password))
        user_dict['hashed_password'] = hashed_password
        del user_dict['password']
        user_dict['role'] = 'user'
        created_user = await self.user_repo.add_user(user_dict)
        print(created_user)
        return UserInDB(**created_user)
        
    
    async def login(self, form_data:LoginRequest):
        token = await self.user_repo.login(form_data)
        return Token(**token)
        
    async def delete_user(self,phone_number, token):
        return await self.user_repo.delete_user(phone_number, token)

    async def update_user(self, user:UserUpdate, token):
        user_dict = user.model_dump()
        hashed_password = bcrypt.hashpw(user.password.encode('utf-8'), bcrypt.gensalt())
        user_dict['hashed_password'] = hashed_password
        del user_dict['password']
        updated_user = await self.user_repo.update_user(user_dict, token)
        return UserOut(**updated_user)
    
    async def read_users_me(self, token):
        user = await self.user_repo.read_users_me(token)
        return UserOut(**user)