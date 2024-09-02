from fastapi import FastAPI, APIRouter

from features.real_time_tracking.api.v1.endpoints import station, bus, driver, populate_database
from features.auth.api.v1.endpoints import auth

app = FastAPI()
app.include_router(auth.auth)
app.include_router(bus.bus)
app.include_router(station.station)
app.include_router(driver.driver)
app.include_router(populate_database.populate)

