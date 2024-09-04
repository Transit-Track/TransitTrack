from fastapi import FastAPI
from app.api.v1 import payment

app = FastAPI()

@app.get("/")
async def read_root():
    return {"message": "Welcome to the TransitTrack API"}

app.include_router(payment.router, prefix="/api/v1/payment", tags=["payment"])

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=8000)