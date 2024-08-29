from fastapi import APIRouter, Depends
from app.db.mongodb import get_database
from app.repositories.payment_repository import PaymentRepository
from app.services.payment_service import PaymentService

router = APIRouter()

@router.post("/initiate-payment/")
async def initiate_payment(user_id: str, amount: float, db = Depends(get_database)):
    payment_repo = PaymentRepository(db)
    payment_service = PaymentService(payment_repo)
    mpesa_code = await payment_service.initiate_payment(user_id, amount)
    return {"mpesa_code": mpesa_code}

@router.post("/confirm-payment/")
async def confirm_payment(mpesa_code: str, db = Depends(get_database)):
    payment_repo = PaymentRepository(db)
    payment_service = PaymentService(payment_repo)
    qr_code = await payment_service.confirm_payment(mpesa_code)
    if qr_code:
        return {"qr_code": qr_code}
    return {"error": "Payment confirmation failed"}

