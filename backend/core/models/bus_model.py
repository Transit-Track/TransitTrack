from .routes_model import Route
from .driver_model import *
from pydantic import BaseModel
from bson import ObjectId

 

class Bus (BaseModel):
    bus_id: int 
    bus_type: str
    capacity: int
    driver: DriverOnBus = None
    idle: bool
    current_route: Route = None
    next_route: Route = None
    _id_counter = 0

    def __init__(self, **data):
        super().__init__(**data)
        if 'bus_id' not in data:
            self.bus_id = self._generate_id()

    @classmethod
    def _generate_id(cls):
        cls._id_counter += 1
        return cls._id_counter
    
    
    class Config:
        json_encoders = {
            ObjectId: str
        }

class BusOut(BaseModel):
    bus_type: str
    route: Route