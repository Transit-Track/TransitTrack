from pydantic import BaseModel, Field
from typing import Optional
from datetime import datetime
from validator import PyObjectId

class Request(BaseModel):
    id: Optional[PyObjectId] = Field(default_factory=PyObjectId, alias="_id")
    start: str
    destination: str
    amount: float
    request_time: datetime = Field(default_factory=datetime.now)
