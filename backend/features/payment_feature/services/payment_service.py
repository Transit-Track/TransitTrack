import base64
from io import BytesIO
import requests
from datetime import datetime
from core.models.transaction_model import Transaction
from core.models.ticket_model import Ticket
from core.models.bus_model import Bus
from core.models.user_model import User
from features.payment_feature.repositories.payment_repository import PaymentRepository
import qrcode
from bson import ObjectId

class PaymentService:
    def __init__(self, payment_repository: PaymentRepository):
        self.payment_repository = payment_repository

    async def initiate_payment(self, user_id: str, amount: float, number_of_tickets: int, start_station: str, destination_station: str, bus_id: str):
        transaction = Transaction(
            user_id=user_id,
            amount=amount,
            start_station=start_station,
            destination_station=destination_station,
            number_of_tickets=number_of_tickets,
            start_time=datetime.utcnow(),
            bus_id=bus_id
        )
        await self.payment_repository.save_transaction(transaction)
        await self.send_stk_push(transaction)

    async def send_stk_push(self, transaction: Transaction):
        url = "https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest"
        headers = {
            "Authorization": "Bearer [access_token]",
            "Content-Type": "application/json"
        }
        payload = {
            "BusinessShortCode": "174379",
            "Password": "MTc0Mzc5YmZiMjc5ZjlhYTliZGJjZjE1OGU5N2RkNzFhNDY3Y2QyZTBjODkzMDU5YjEwZjc4ZTZiNzJhZGExZWQyYzkxOTIwMjQwOTE4MTQyNDI1",
            "Timestamp": datetime.now().strftime("%Y%m%d%H%M%S"),
            "TransactionType": "CustomerPayBillOnline",
            "Amount": transaction.amount,
            "PartyA": transaction.user_id,
            "PartyB": "174379",
            "PhoneNumber": transaction.user_id,
            "CallBackURL": "https://yourdomain.com/api/v1/payment/callback",
            "AccountReference": "account",
            "TransactionDesc": "test"
        }
        response = requests.post(url, headers=headers, json=payload)
        return response.json()

    async def handle_callback(self, data):
        # Use a mock transaction instead of fetching it from the repository
        mock_transaction_id = ObjectId(data['Body']['stkCallback']['CheckoutRequestID'])
        result_code = data['Body']['stkCallback']['ResultCode']

        # Create a mock transaction object
        transaction = Transaction(
            user_id="254700123456",
            amount=100.0,
            start_station="Station A",
            destination_station="Station B",
            number_of_tickets=2,
            start_time=datetime.utcnow(),
            bus_id="64f20e4a47b5f75c21b69eb3"
        )

        if result_code == 0:
            transaction.status = "completed"
            transaction.mpesa_code = data['Body']['stkCallback']['CallbackMetadata']['Item'][1]['Value']

            qr_code_base64 = await self.generate_qr_code(transaction)

            return {
                "message": "Payment successful",
                "qr_code_base64": qr_code_base64
            }
        else:
            transaction.status = "failed"
            return {
                "message": "Payment failed",
                "result_code": result_code
            }


    async def generate_qr_code(self, transaction: Transaction):
        qr_data = f"Payment Amount: {transaction.amount}, Tickets: {transaction.number_of_tickets}, Start: {transaction.start_station}, Destination: {transaction.destination_station}"
        qr = qrcode.make(qr_data)
        buffered = BytesIO()
        qr.save(buffered, format="PNG")
        qr_code_base64 = base64.b64encode(buffered.getvalue()).decode("utf-8")
        transaction.qr_code = qr_code_base64
        # await self.payment_repository.update_transaction(transaction)
        
        return qr_code_base64  


    async def update_bus_capacity(self, bus_id: str):
        bus = await self.payment_repository.get_bus_by_id(bus_id)
        if bus:
            bus.capacity += 1
            await self.payment_repository.update_bus(bus)
    
    async def get_transaction_by_id(self, transaction_id: ObjectId) -> Transaction:
        transaction_data = await self.db.transactions.find_one({"_id": transaction_id})
        if not transaction_data:
            raise ValueError("Transaction not found")
        return Transaction(**transaction_data)
    