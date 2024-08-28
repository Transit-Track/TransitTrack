from pydantic import BaseModel, Field
from typing import Optional
from bson import ObjectId
from datetime import datetime

class PyObjectId(ObjectId):
    @classmethod
    def __get_validators__(cls):
        yield cls.validate

    @classmethod
    def validate(cls, v):
        if not ObjectId.is_valid(v):
            raise ValueError("Invalid objectid")
        return ObjectId(v)

    @classmethod
    def __modify_schema__(cls, field_schema):
        field_schema.update(type="string")

class Payment(BaseModel):
    id: Optional[PyObjectId] = Field(default_factory=PyObjectId, alias="_id")
    user_id: str
    amount: float
    mpesa_code: str
    status: str = "pending"
    qr_code: Optional[str] = None
    created_at: datetime = Field(default_factory=datetime.utcnow)

    class Config:
        allow_population_by_field_name = True
        arbitrary_types_allowed = True
        json_encoders = {ObjectId: str}

class Request(BaseModel):
    id: Optional[PyObjectId] = Field(default_factory=PyObjectId, alias="_id")
    start: str
    destination: str
    amount: float

class Transaction(BaseModel):
    id: Optional[PyObjectId] = Field(default_factory=PyObjectId, alias="_id")
    ticket_id: PyObjectId
    start_time: datetime
    commit_time: Optional[datetime] = None
    rollback_time: Optional[datetime] = None
    status: str

class Ticket(BaseModel):
    id: Optional[PyObjectId] = Field(default_factory=PyObjectId, alias="_id")
    user_id: PyObjectId
    bus_id: PyObjectId
    issue_date: datetime
    start_station: str
    destination_station: str
    price: float
    expiry_date: datetime
    status: str

class Bus(BaseModel):
    id: Optional[PyObjectId] = Field(default_factory=PyObjectId, alias="_id")
    route_id: PyObjectId
    location: str
    capacity: int
    status: str

class User(BaseModel):
    name: str
    password: str
    phone_no: str
    email: str
    home_address: str
    work_address: str
    payment_transaction: Optional[PyObjectId] = None