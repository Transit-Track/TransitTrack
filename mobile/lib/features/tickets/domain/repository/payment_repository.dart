abstract class PaymentRepository {
  // Method to initiate the payment process
  Future<void> initiatePayment({
    required String userId,
    required double amount,
    required int numberOfTickets,
    required String start,
    required String destination,
    required String busId,
  });

  
  Future<String> handlePaymentCallback(Map<String, dynamic> callbackData);
}
