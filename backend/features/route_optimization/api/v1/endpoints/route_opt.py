from fastapi import APIRouter

route_opt = APIRouter()

@route_opt.get("/next_route")
def get_next_route(bus_id: int):
    return {"route": "Route 1"}
@route_opt.post("/current_route")
def set_current_route(bus_id: int, route_id: int):
    return {"route": "Route 1"}