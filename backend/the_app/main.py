from fastapi import FastAPI, APIRouter

from real_time_tracking.api.v1.endpoints import station, bus, driver, populate_database

app = FastAPI()
app.include_router(bus.bus)
app.include_router(station.station)
app.include_router(driver.driver)
app.include_router(populate_database.populate)
