from typing import List
from fastapi import APIRouter, Depends

from features.real_time_tracking.repositories.bus_repo import BusRepository
from features.real_time_tracking.services.bus_service import BusService
from core.models.bus_model import Bus

bus = APIRouter()

busService = BusService(BusRepository())
def get_busService():
    return busService

@bus.get("/search_bus_by_route", response_model=List[Bus])
async def getBuses(start_station, end_station, bus_service: BusService = Depends(get_busService)):
    return await bus_service.search_bus_by_route(start_station, end_station)

@bus.put("/add_bus_to_my_route")
async def addBusToMyRoute(bus_id, bus_service: BusService = Depends(get_busService)):
    return await bus_service.add_bus_to_my_route(bus_id)

@bus.put("/remove_bus_from_my_route")
async def removeBusFromMyRoute(bus_id, bus_service: BusService = Depends(get_busService)):
    return await bus_service.remove_bus_from_my_route(bus_id)

@bus.get("/get_my_route_buses", response_model=List[Bus])
async def getMyRouteBuses(bus_service: BusService = Depends(get_busService)):
    return await bus_service.get_my_route_buses()

@bus.get("/get_bus_by_id", response_model=Bus)
async def getBusById(bus_id, bus_service: BusService = Depends(get_busService)):
    return await bus_service.get_bus_by_id(bus_id)
