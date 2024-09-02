from fastapi import APIRouter, Depends
from fastapi.security import OAuth2PasswordBearer

from features.auth.repositories.user_repo import UserRepository
from features.auth.services.user_service import UserService
from core.models.user_model import *


auth = APIRouter()
userService = UserService(UserRepository())
oath2_schema = OAuth2PasswordBearer(tokenUrl="token")

def get_userService():
    return userService

@auth.post('/signup',response_model=UserInDB)
async def singup(user:UserCreate, user_service: UserService = Depends(get_userService)):
    return await user_service.signup(user)


@auth.post('/login', response_model=Token)
async def login_for_access_token(form_data: LoginRequest, user_service: UserService = Depends(get_userService)):
    return await user_service.login(form_data)

@auth.delete('/delete_account')
async def delete_account(phone_number:str, token:str = Depends(oath2_schema), user_service: UserService = Depends(get_userService)):
    # token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NSIsInJvbGUiOiJ1c2VyIiwiZXhwIjoxNzI0ODQ3MDM2fQ.L5QljxXvXeODfIwsSx6tTMhV0V1wUN0Q71mYZdlq2yE'
    return await user_service.delete_user(phone_number, token)

@auth.get('/users/me/', response_model=UserOut)
async def read_users_me(token:str = Depends(oath2_schema), user_service: UserService = Depends(get_userService)):
    # token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyMzQiLCJyb2xlIjoidXNlciIsImV4cCI6MTcyNDg1MTA3OX0.gsFmdNP_wF7fbfdldUTzeVrQGMvBRj7Zx4F26oq3pwc'
    return await user_service.read_users_me(token)
    