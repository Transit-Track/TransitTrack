import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

import unittest
from unittest.mock import AsyncMock, patch, MagicMock
from datetime import datetime
from features.payment_feature.services.payment_service import PaymentService
from features.payment_feature.repositories.payment_repository import PaymentRepository
from core.models.transaction_model import Transaction
from bson import ObjectId

class TestPaymentService(unittest.IsolatedAsyncioTestCase):
    def setUp(self):
        self.payment_repository = PaymentRepository()
        self.payment_service = PaymentService(self.payment_repository)

    @patch('features.payment_feature.repositories.payment_repository.PaymentRepository.save_transaction', new_callable=AsyncMock)
    @patch('features.payment_feature.services.payment_service.PaymentService.send_stk_push', new_callable=AsyncMock)
    async def test_initiate_payment(self, mock_send_stk_push, mock_save_transaction):
        user_id = "user123"
        amount = 100.0
        number_of_tickets = 2
        start_station = "Station A"
        destination_station = "Station B"
        bus_id = "bus123"

        await self.payment_service.initiate_payment(user_id, amount, number_of_tickets, start_station, destination_station, bus_id)

        mock_save_transaction.assert_awaited_once()
        mock_send_stk_push.assert_awaited_once()

    @patch('features.payment_feature.repositories.payment_repository.PaymentRepository.get_transaction_by_id', new_callable=AsyncMock)
    @patch('features.payment_feature.repositories.payment_repository.PaymentRepository.update_transaction', new_callable=AsyncMock)
    @patch('features.payment_feature.services.payment_service.PaymentService.generate_qr_code', new_callable=AsyncMock)
    @patch('features.payment_feature.repositories.payment_repository.PaymentRepository.get_bus_by_id', new_callable=AsyncMock)
    @patch('features.payment_feature.repositories.payment_repository.PaymentRepository.update_bus', new_callable=AsyncMock)
    async def test_handle_callback_success(self, mock_update_bus, mock_get_bus_by_id, mock_generate_qr_code, mock_update_transaction, mock_get_transaction_by_id):
        transaction_id = ObjectId()
        transaction_data = Transaction(
            user_id="user123",
            amount=100.0,
            start_station="Station A",
            destination_station="Station B",
            number_of_tickets=2,
            start_time=datetime.utcnow(),
            bus_id="bus123"
        )
        mock_get_transaction_by_id.return_value = transaction_data
        mock_get_bus_by_id.return_value = MagicMock()

        callback_data = {
            "Body": {
                "stkCallback": {
                    "MerchantRequestID": "21605-295434-4",
                    "CheckoutRequestID": str(transaction_id),
                    "ResultCode": 0,
                    "ResultDesc": "The service request is processed successfully.",
                    "CallbackMetadata": {
                        "Item": [
                            {"Name": "Amount", "Value": 100.0},
                            {"Name": "MpesaReceiptNumber", "Value": "LK451H35OP"},
                            {"Name": "Balance"},
                            {"Name": "TransactionDate", "Value": 20171104184944},
                            {"Name": "PhoneNumber", "Value": 254727894083}
                        ]
                    }
                }
            }
        }

        await self.payment_service.handle_callback(callback_data)

        mock_get_transaction_by_id.assert_awaited_once_with(transaction_id)
        mock_update_transaction.assert_awaited_once()
        mock_generate_qr_code.assert_awaited_once()
        mock_get_bus_by_id.assert_awaited_once_with(transaction_data.bus_id)
        mock_update_bus.assert_awaited_once()

    @patch('features.payment_feature.repositories.payment_repository.PaymentRepository.get_transaction_by_id', new_callable=AsyncMock)
    @patch('features.payment_feature.repositories.payment_repository.PaymentRepository.update_transaction', new_callable=AsyncMock)
    async def test_handle_callback_failure(self, mock_update_transaction, mock_get_transaction_by_id):
        transaction_id = ObjectId()
        transaction_data = Transaction(
            user_id="user123",
            amount=100.0,
            start_station="Station A",
            destination_station="Station B",
            number_of_tickets=2,
            start_time=datetime.utcnow(),
            bus_id="bus123"
        )
        mock_get_transaction_by_id.return_value = transaction_data

        callback_data = {
            "Body": {
                "stkCallback": {
                    "MerchantRequestID": "21605-295434-4",
                    "CheckoutRequestID": str(transaction_id),
                    "ResultCode": 1,
                    "ResultDesc": "The service request failed."
                }
            }
        }

        await self.payment_service.handle_callback(callback_data)

        mock_get_transaction_by_id.assert_awaited_once_with(transaction_id)
        mock_update_transaction.assert_awaited_once()

if __name__ == '__main__':
    unittest.main()