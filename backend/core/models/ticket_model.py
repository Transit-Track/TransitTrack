from pydantic import BaseModel, Field
from typing import Optional
from datetime import datetime
from validator import PyObjectId

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