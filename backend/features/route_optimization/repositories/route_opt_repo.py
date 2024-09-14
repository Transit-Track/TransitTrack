from core.config.db import client
from core.models.routes_model import Route
from features.route_optimization.repositories.scheduler import Scheduler


class RouteOptRepo:
    def __init__(self) -> None:
        self.route_repo = client.local.transittrack.routes
        self.bus_repo = client.local.transittrack.buses
        self.scheduler = Scheduler()
        
    async def get_next_route(self, bus_id: int):
        route_id = self.scheduler.schedule[bus_id]
        route = await self.route_repo.find_one({'route_id':route_id})
        return route

    async def set_current_route(self, bus_id: int, route_id: int):
        bus = await self.bus_repo.find_one({"bus_id": bus_id})
        route = await self.route_repo.find_one({'route_id':route_id})
        bus["current_route"] = Route(route)
        return {"route": "set successfully"}
    
    def get_idle_buses(self):
        return self.bus_repo.find({"idle": True})
    def get_all_routes(self):
        return self.route_repo.find().to_list(length=None)