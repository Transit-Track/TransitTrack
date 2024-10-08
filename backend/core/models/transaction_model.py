from bson import ObjectId
from pydantic import BaseModel, Field
from typing import Optional
from core.models.validator import PyObjectId
from datetime import datetime

class Transaction(BaseModel):
    id: Optional[PyObjectId] = Field(default_factory=PyObjectId, alias="_id")
    user_id: str
    amount: float
    mpesa_code: Optional[str] = None
    status: str = "pending"
    qr_code: Optional[str] = None
    created_at: datetime = Field(default_factory=datetime.utcnow)
    start_station: str
    destination_station: str
    number_of_tickets: int
    ticket_id: Optional[PyObjectId] = None
    start_time: datetime
    commit_time: Optional[datetime] = None
    rollback_time: Optional[datetime] = None
    bus_id: Optional[PyObjectId] = None

    class Config:
        populate_by_name = True
        arbitrary_types_allowed = True
        json_encoders = {ObjectId: str}