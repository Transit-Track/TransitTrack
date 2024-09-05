from fastapi import FastAPI, APIRouter
from features.payment_feature.api.v1 import payment
from features.real_time_tracking.api.v1.endpoints import station, bus, driver, populate_database
from features.auth.api.v1.endpoints import auth


app = FastAPI()
app.include_router(auth.auth)
app.include_router(bus.bus)
app.include_router(station.station)
app.include_router(driver.driver)
app.include_router(populate_database.populate)
app.include_router(payment.router, tags=["payment"])


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=8000)