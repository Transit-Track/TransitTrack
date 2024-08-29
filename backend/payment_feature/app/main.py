from fastapi import FastAPI
from app.api.v1 import payment

app = FastAPI()

app.include_router(payment.router, prefix="/api/v1/payment", tags=["payment"])

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
