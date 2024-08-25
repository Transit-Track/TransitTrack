from bson import ObjectId
from real_time_tracking.models.routes_model import Route
from .driver_model import  Driver, DriverOnBus
from pydantic import BaseModel
 

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