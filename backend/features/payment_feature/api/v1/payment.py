from fastapi import APIRouter, Depends
from app.db.mongodb import get_database
from app.repositories.payment_repository import PaymentRepository
from app.services.payment_service import PaymentService

router = APIRouter()

@router.post("/initiate-payment/", operation_id="initiate_payment_v1")
async def initiate_payment(user_id: str, amount: float, number_of_tickets: int, start_station: str, destination_station: str, db = Depends(get_database)):
    payment_repo = PaymentRepository(db)
    payment_service = PaymentService(payment_repo)
    mpesa_code = await payment_service.initiate_payment(user_id, amount, number_of_tickets, start_station, destination_station)
    return {"mpesa_code": mpesa_code}

@router.post("/confirm-payment/", operation_id="confirm_payment_v1")
async def confirm_payment(mpesa_code: str, db = Depends(get_database)):
    payment_repo = PaymentRepository(db)
    payment_service = PaymentService(payment_repo)
    qr_code = await payment_service.confirm_payment(mpesa_code)
    if qr_code:
        return {"qr_code": qr_code}
    return {"error": "Payment confirmation failed"}

@router.post("/register-urls/", operation_id="register_urls_v1")
async def register_urls(db = Depends(get_database)):
    payment_repo = PaymentRepository(db)
    payment_service = PaymentService(payment_repo)
    response = payment_service.register_mpesa_urls()
    return response

@router.post("/simulate-payment/", operation_id="simulate_payment_v1")
async def simulate_payment(amount: float, phone_number: str, db = Depends(get_database)):
    payment_repo = PaymentRepository(db)
    payment_service = PaymentService(payment_repo)
    response = payment_service.simulate_mpesa_payment(amount, phone_number)
    return response