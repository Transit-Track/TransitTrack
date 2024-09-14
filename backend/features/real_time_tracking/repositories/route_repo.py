from core.models import routes_model
from core.config.db import client as db


class RouteRepository:
    def __init__(self):
        self.db = db.transittrack.routes
    
    
    async def is_route_exist(self, route_id, start_station, end_station):
        query = {
                "route_id": route_id,
                "stations.name": {"$all": [start_station, end_station]}
            }
        route = await self.db.find_one(query)
        if route:
            stations = [station['name'] for station in route['stations']]
            try:
                start_index = stations.index(start_station)
                end_index = stations.index(end_station)
                return start_index < end_index
            except ValueError:
                return False
        return False 
    
   