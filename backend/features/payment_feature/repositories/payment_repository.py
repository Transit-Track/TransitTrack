from core.config.db import transactions_collection, tickets_collection, buses_collection, users_collection
from core.models.transaction_model import Transaction
from core.models.bus_model import Bus
from bson import ObjectId

class PaymentRepository:
    async def save_transaction(self, transaction: Transaction):
        await transactions_collection.insert_one(transaction.dict(by_alias=True))

    async def get_transaction_by_id(self, transaction_id: ObjectId) -> Transaction:
        transaction_data = await transactions_collection.find_one({"_id": transaction_id})
        if transaction_data:
            return Transaction(**transaction_data)
        return None

    async def update_transaction(self, transaction: Transaction):
        await transactions_collection.update_one({"_id": transaction.id}, {"$set": transaction.model_dump(by_alias=True)})

    async def get_bus_by_id(self, bus_id: ObjectId) -> Bus:
        bus_data = await buses_collection.find_one({"_id": bus_id})
        if bus_data:
            return Bus(**bus_data)
        return None

    async def update_bus(self, bus: Bus):
        await buses_collection.update_one({"_id": bus.id}, {"$set": bus.dict(by_alias=True)})