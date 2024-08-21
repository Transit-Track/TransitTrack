from real_time_tracking.models.routes_model import Route
from .driver_model import Driver
from pydantic import BaseModel
 

class Bus (BaseModel):
    bus_id: int
    route_id: int
    capacity: int
    driver: Driver
    status: bool
    route: Route
        
