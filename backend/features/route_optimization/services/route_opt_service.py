from core.models.routes_model import RouteOut   
from features.route_optimization.repositories.route_opt_repo import RouteOptRepo


class RouteOptService:
    def __init__(self, repo: RouteOptRepo) -> None:
        self.repo = repo
        
    def get_next_route(self, bus_id: int):
        return RouteOut(**self.repo.get_next_route(bus_id))

    async def set_current_route(self, bus_id: int, route_id: int):
        return await self.repo.set_current_route(bus_id, route_id)