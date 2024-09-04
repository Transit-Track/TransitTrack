from app.repositories.payment_repository import PaymentRepository
from app.core.config import settings
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

    async def initiate_payment(self, user_id: str, amount: float, number_of_tickets: int, start_station: str, destination_station: str) -> str:
        mpesa_code = self._generate_mpesa_code()
        payment_data = {
            "user_id": user_id,
            "amount": amount,
            "mpesa_code": mpesa_code,
            "status": "pending",
            "number_of_tickets": number_of_tickets,
            "start_station": start_station,
            "destination_station": destination_station
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
                ticket_data = {
                    "user_id": payment.user_id,
                    "start_station": payment.start_station,
                    "destination_station": payment.destination_station,
                    "price": payment.amount,
                    "status": "active"
                }
                await self.payment_repository.create_ticket(ticket_data)
                return qr_code
            else:
                await self.payment_repository.update_payment_status(payment.id, "failed")
        return None

    def _generate_mpesa_code(self):
        return ''.join(random.choices(string.ascii_uppercase + string.digits, k=10))

    def _get_mpesa_access_token(self) -> str:
        url = "https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials"
        response = requests.get(url, auth=(settings.MPESA_CONSUMER_KEY, settings.MPESA_CONSUMER_SECRET))
        response_data = response.json()
        return response_data['access_token']

    def _check_mpesa_payment_status(self, mpesa_code: str) -> str:
        access_token = self._get_mpesa_access_token()
        url = "https://apisandbox.safaricom.et/mpesa/b2c/simulatetransaction/v1/request"
        headers = {
            "Authorization": f"Bearer {access_token}",
            "Content-Type": "application/json"
        }
        payload = {
            "CommandID": "CustomerPayBillOnline",
            "Amount": "10",  # Replace with actual amount
            "Msisdn": "254724628580",  # Replace with actual customer phone number
            "BillRefNumber": mpesa_code,
            "ShortCode": settings.MPESA_SHORTCODE
        }

        response = requests.post(url, headers=headers, json=payload)
        response_data = response.json()

        if response_data.get("ResponseDescription") == "Accept the service request successfully.":
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

    def register_mpesa_urls(self):
        access_token = self._get_mpesa_access_token()
        url = "https://apisandbox.safaricom.et/v1/c2b-register-url/register"
        headers = {
            "Authorization": f"Bearer {access_token}",
            "Content-Type": "application/json"
        }
        payload = {
            "ShortCode": settings.MPESA_SHORTCODE,
            "ResponseType": "Completed",
            "ConfirmationURL": "https://mydomain.com/confirmation",
            "ValidationURL": "https://mydomain.com/validation"
        }

        response = requests.post(url, headers=headers, json=payload)
        return response.json()

    def simulate_mpesa_payment(self, amount: float, phone_number: str):
        access_token = self._get_mpesa_access_token()
        url = "https://apisandbox.safaricom.et/v1/c2b-register-url/register"
        headers = {
            "Authorization": f"Bearer {access_token}",
            "Content-Type": "application/json"
        }
        payload = {
            "CommandID": "CustomerPayBillOnline",
            "Amount": amount,
            "Msisdn": phone_number,
            "BillRefNumber": "00000",
            "ShortCode": settings.MPESA_SHORTCODE
        }

        response = requests.post(url, headers=headers, json=payload)
        return response.json()