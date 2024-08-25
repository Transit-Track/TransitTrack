
from fastapi import APIRouter
from typing import List
from core.models.bus_model import Bus
from core.models.station_model import Station
from core.models.routes_model import Route

from core.models.driver_model import Driver, DriverOnBus
from core.models.location_model import Location
from core.config.db import client


populate = APIRouter()
@populate.get("/populate")
async def populate_db():

    db = client.local.transittrack

    drivers_collection = db.drivers
    buses_collection = db.buses
    routes_collection = db.routes
    stations_collection = db.stations


    locations = [
    Location(latitude=34.0522, longitude=-118.2437, location_id=1),
    Location(latitude=40.7128, longitude=-74.0060, location_id=2),
    Location(latitude=37.7749, longitude=-122.4194, location_id=3)
    ]

    

    # Sample Station data
    stations = [
    Station(station_id=1, name="Station A", location=locations[0]),
    Station(station_id=2, name="Station B", location=locations[1]),
    Station(station_id=3, name="Station C", location=locations[2])
    ]


    # Sample Route data
    routes = [
    Route(
        route_id=1,
        stations=[stations[0], stations[1]],
        distance=10.5
    ),
    Route(
        route_id=2,
        stations=[stations[1], stations[2]],
        distance=15.0
    ),
    Route(
        route_id=3,
        stations=[stations[0], stations[2]],
        distance=20.0
    )
    ]
    route = Route(
    route_id=1,
    stations=[
        Station(station_id=1, name="Station A", location=locations[0]),
        Station(station_id=2, name="Station B", location=locations[1])
    ],
    distance=10.5
    )
    driver = DriverOnBus(

    phone_number="555-1234",
    location=locations[0]
)


    # Sample Bus data
    buses = [
    Bus(
        bus_id=1,
        bus_type="Anbessa",
        route_id=1,
        capacity=50,
        driver=driver,
        idle=True,
        route=route
    ),
    Bus(
        bus_id=2,
        bus_type="Sheger",
        route_id=1,
        capacity=60,
        driver=driver,
        idle=False,
        route=route
    )
    ]

    

        

    for station in stations:
        station_dict = station.model_dump()
        await stations_collection.insert_one(station_dict)

    for route in routes:
        route_dict = route.model_dump()
        routes_collection.insert_one(route_dict)

    for bus in buses:
        bus_dict = bus.model_dump()
        await buses_collection.insert_one(bus_dict)



    for station in stations:
        station_dict = station.model_dump()
        await stations_collection.insert_one(station_dict)

    for route in routes:
        route_dict = route.model_dump()
        routes_collection.insert_one(route_dict)

    for bus in buses:
        bus_dict = bus.model_dump()
        await buses_collection.insert_one(bus_dict)
        
    return {"message": "Database populated successfully"}

