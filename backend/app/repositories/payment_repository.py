from app.models.payment import Payment, Request, Transaction, Ticket, Bus, User
from bson import ObjectId
from typing import Optional

class PaymentRepository:
    def __init__(self, db):
        self.db = db
        self.payment_collection = self.db.get_collection("payments")
        self.request_collection = self.db.get_collection("requests")
        self.transaction_collection = self.db.get_collection("transactions")
        self.ticket_collection = self.db.get_collection("tickets")
        self.bus_collection = self.db.get_collection("buses")
        self.user_collection = self.db.get_collection("users")

    async def create_payment(self, payment_data: dict) -> Payment:
        result = await self.payment_collection.insert_one(payment_data)
        payment_data["_id"] = result.inserted_id
        return Payment(**payment_data)

    async def get_payment_by_code(self, mpesa_code: str) -> Optional[Payment]:
        payment = await self.payment_collection.find_one({"mpesa_code": mpesa_code})
        if payment:
            return Payment(**payment)
        return None

    async def update_payment_status(self, payment_id: ObjectId, status: str, qr_code: Optional[str] = None) -> Payment:
        update_data = {"status": status}
        if qr_code:
            update_data["qr_code"] = qr_code
        
        await self.payment_collection.update_one({"_id": payment_id}, {"$set": update_data})
        updated_payment = await self.payment_collection.find_one({"_id": payment_id})
        return Payment(**updated_payment)

    async def create_ticket(self, ticket_data: dict) -> Ticket:
        result = await self.ticket_collection.insert_one(ticket_data)
        ticket_data["_id"] = result.inserted_id
        return Ticket(**ticket_data)