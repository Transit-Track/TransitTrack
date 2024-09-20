from fastapi import APIRouter, HTTPException
from features.payment_feature.repositories import payment_repository
from features.payment_feature.services.payment_service import PaymentService
from core.models.request_model import Request
from pydantic import BaseModel

class PaymentRequest(BaseModel):
    user_id: str
    amount: float
    number_of_tickets: int
    start: str
    destination: str
    bus_id: str  

router = APIRouter()

payment_service = PaymentService(payment_repository)

@router.post("/initiate")
def initiate_payment(request: PaymentRequest):  # Use the updated Pydantic model
    try:
        payment_service.initiate_payment(
            request.user_id, 
            request.amount, 
            request.number_of_tickets, 
            request.start, 
            request.destination,
            request.bus_id  
        )
        return {"message": "Payment initiated successfully"}
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

@router.post("/callback")
async def payment_callback(data: dict):
    print(data)
    try:
        result = await payment_service.handle_callback(data)
        return result  
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))
