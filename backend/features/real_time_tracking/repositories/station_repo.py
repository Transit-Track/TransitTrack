import logging
from fastapi import HTTPException
from core.config.db import client as db
from core.models.location_model import Location

# logging.basicConfig(level=logging.DEBUG)
# logging.getLogger().setLevel(logging.DEBUG)

class StationRepository:
    def __init__(self):
        self.db = db.local.transittrack.stations
        self.db.create_index([("geoLocation", "2dsphere")])
    
    async def get_nearby_station(self, location: Location, radius: int):
        # Validate coordinates
        # await self.update_stations_location()
        if not (-180 <= location.longitude <= 180):
            raise HTTPException(status_code=400, detail="Longitude must be between -180 and 180")
        if not (-90 <= location.latitude <= 90):
            raise HTTPException(status_code=400, detail="Latitude must be between -90 and 90")

        query = {
            "geoLocation": {
                "$near": {
                    "$geometry": location.to_geojson(),
                    "$maxDistance": radius * 10**6
                }
            }
        }
        cursor = self.db.find(query)
        stations = await cursor.to_list(length=None)
        return stations

    # async def update_stations_location(self):
    #     stations = self.db.find()
       
    #     async for station in stations:
    #         station['geoLocation'] = Location(**station['location']).to_geojson()
    #         print(station)
    #         await self.db.replace_one({'_id': station['_id']}, station)