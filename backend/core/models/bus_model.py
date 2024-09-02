from .routes_model import Route
from .driver_model import *
from pydantic import BaseModel
from bson import ObjectId

 

class Bus (BaseModel):
    bus_id: int
    bus_type: str
    route_id: int
    capacity: int
    driver: DriverOnBus
    idle: bool
    route: Route
    
    class Config:
        json_encoders = {
            ObjectId: str
        }