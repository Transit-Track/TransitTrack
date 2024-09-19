abstract class PaymentRepository {
  Future<void> initiatePayment({
    required String userId,
    required double amount,
    required int numberOfTickets,
    required String start,
    required String destination,
    required String busId,
  });

  Future<void> handlePaymentCallback(Map<String, dynamic> data);
}
