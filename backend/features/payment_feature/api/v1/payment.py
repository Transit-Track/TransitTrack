from fastapi import APIRouter, HTTPException
from features.payment_feature.services.payment_service import PaymentService
from core.models.request_model import Request

router = APIRouter()

payment_service = PaymentService()

@router.post("/initiate")
def initiate_payment(request: Request):
    try:
        payment_service.initiate_payment(request.user_id, request.amount, request.number_of_tickets, request.start, request.destination)
        return {"message": "Payment initiated successfully"}
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

@router.post("/callback")
def payment_callback(data: dict):
    try:
        payment_service.handle_callback(data)
        return {"message": "Callback handled successfully"}
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))