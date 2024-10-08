from fastapi import FastAPI, APIRouter
from features.payment_feature.api.v1 import payment
from features.real_time_tracking.api.v1.endpoints import station, bus, driver
from features.auth.api.v1.endpoints import auth
from features.route_optimization.api.v1.endpoints import route_opt
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()
app.include_router(auth.auth)
app.include_router(bus.bus)
app.include_router(station.station)
app.include_router(driver.driver)
app.include_router(route_opt.route_opt)
app.include_router(payment.router, tags=["payment"])

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Change this to specific origins if needed
    allow_credentials=True,
    allow_methods=["*"],  # Allow all HTTP methods
    allow_headers=["*"],
)
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=8000)