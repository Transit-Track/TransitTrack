from app.models.payment import Payment, Request, Transaction, Ticket, Bus, User
from app.db.mongodb import get_database
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

    async def get_payment_by_code(self, mpesa_code: str) -> Payment:
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

    async def create_request(self, request_data: dict) -> Request:
        result = await self.request_collection.insert_one(request_data)
        request_data["_id"] = result.inserted_id
        return Request(**request_data)

    async def create_transaction(self, transaction_data: dict) -> Transaction:
        result = await self.transaction_collection.insert_one(transaction_data)
        transaction_data["_id"] = result.inserted_id
        return Transaction(**transaction_data)

    async def create_ticket(self, ticket_data: dict) -> Ticket:
        result = await self.ticket_collection.insert_one(ticket_data)
        ticket_data["_id"] = result.inserted_id
        return Ticket(**ticket_data)

    async def update_bus_capacity(self, bus_id: ObjectId, decrement: int) -> Bus:
        bus = await self.bus_collection.find_one({"_id": bus_id})
        if bus:
            new_capacity = bus["capacity"] - decrement
            await self.bus_collection.update_one({"_id": bus_id}, {"$set": {"capacity": new_capacity}})
            updated_bus = await self.bus_collection.find_one({"_id": bus_id})
            return Bus(**updated_bus)
        return None

    async def update_user_payment_transaction(self, user_id: ObjectId, transaction_id: ObjectId) -> User:
        await self.user_collection.update_one({"_id": user_id}, {"$set": {"payment_transaction": transaction_id}})
        updated_user = await self.user_collection.find_one({"_id": user_id})
        return User(**updated_user)