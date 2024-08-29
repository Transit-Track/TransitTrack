from app.repositories.payment_repository import PaymentRepository
import random
import string
import requests
import base64
import qrcode
import io
from datetime import datetime

class PaymentService:
    def __init__(self, payment_repository: PaymentRepository):
        self.payment_repository = payment_repository

    async def initiate_payment(self, user_id: str, amount: float) -> str:
        mpesa_code = self._generate_mpesa_code()
        payment_data = {
            "user_id": user_id,
            "amount": amount,
            "mpesa_code": mpesa_code,
            "status": "pending",
        }
        payment = await self.payment_repository.create_payment(payment_data)
        return payment.mpesa_code
    
    async def confirm_payment(self, mpesa_code: str):
        payment = await self.payment_repository.get_payment_by_code(mpesa_code)
        if payment and payment.status == "pending":
            payment_status = self._check_mpesa_payment_status(mpesa_code)
            if payment_status == "success":
                qr_code = self._generate_qr_code(payment.amount, payment.number_of_tickets, payment.start_station, payment.destination_station)
                await self.payment_repository.update_payment_status(payment.id, "completed", qr_code)
                return qr_code
            else:
                await self.payment_repository.update_payment_status(payment.id, "failed")
        return None

    def _generate_mpesa_code(self):
        return ''.join(random.choices(string.ascii_uppercase + string.digits, k=10))

    def _check_mpesa_payment_status(self, mpesa_code: str) -> str:
        url = "https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest"
        headers = {
            "Authorization": "Bearer [access_token]",  # Replace with actual access token
            "Content-Type": "application/json"
        }
        timestamp = datetime.now().strftime('%Y%m%d%H%M%S')
        business_short_code = "174379"  # Replace with actual business short code
        passkey = "your_passkey"  # Replace with actual passkey
        password = base64.b64encode((business_short_code + passkey + timestamp).encode()).decode()
        
        payload = {
            "BusinessShortCode": business_short_code,
            "Password": password,
            "Timestamp": timestamp,
            "TransactionType": "CustomerPayBillOnline",
            "Amount": "10",  # Replace with actual amount
            "PartyA": "+251974825354",  # Replace with actual customer phone number
            "PartyB": business_short_code,
            "PhoneNumber": "+251974825354",  # Replace with actual customer phone number
            "CallBackURL": "https://your_callback_url",  # Replace with actual callback URL
            "AccountReference": "account",
            "TransactionDesc": "test"
        }

        response = requests.post(url, headers=headers, json=payload)
        response_data = response.json()

        if response_data.get("ResponseCode") == "0":
            return "success"
        else:
            return "failed"

    def _generate_qr_code(self, amount, number_of_tickets, start_station, destination_station):
        qr = qrcode.QRCode(
            version=1,
            error_correction=qrcode.constants.ERROR_CORRECT_L,
            box_size=10,
            border=4,
        )

        qr_data = f"Payment Amount: {amount}, Tickets: {number_of_tickets}, Start: {start_station}, Destination: {destination_station}"
        qr.add_data(qr_data)
        qr.make(fit=True)

        img = qr.make_image(fill_color='blue', back_color='black')

        buffer = io.BytesIO()
        img.save(buffer, format="PNG")
        buffer.seek(0)

        # Convert the image to a base64 string
        img_base64 = base64.b64encode(buffer.getvalue()).decode('utf-8')
        return img_base64