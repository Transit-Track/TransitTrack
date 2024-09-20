from fastapi import APIRouter, Depends

from core.models.routes_model import RouteOut
from features.route_optimization.repositories.route_opt_repo import RouteOptRepo
from features.route_optimization.services.route_opt_service import RouteOptService

route_opt = APIRouter()

def get_route_opt_service():
    return RouteOptService(RouteOptRepo())

@route_opt.get("/next_route", response_model=RouteOut)
def get_next_route(bus_id: int, route_opt_service: RouteOptService = Depends(get_route_opt_service)):
    return route_opt_service.get_next_route(bus_id)
@route_opt.post("/current_route")
def set_current_route(bus_id: int, route_id: int, route_opt_service: RouteOptService = Depends(get_route_opt_service)):
    return route_opt_service.set_current_route(bus_id, route_id)