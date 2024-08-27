from fastapi import FastAPI, APIRouter

from features.real_time_tracking.api.v1.endpoints import station, bus, driver

app = FastAPI()
app.include_router(bus.bus)
app.include_router(station.station)
app.include_router(driver.driver)