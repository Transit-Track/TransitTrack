import 'package:transittrack/features/tickets/data/data_sources/ticket_remote_datasource.dart';
import 'package:transittrack/features/tickets/domain/repository/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource remoteDataSource;

  PaymentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> initiatePayment({
    required String userId,
    required double amount,
    required int numberOfTickets,
    required String start,
    required String destination,
    required String busId,
  }) async {
    return remoteDataSource.initiatePayment(
      userId: userId,
      amount: amount,
      numberOfTickets: numberOfTickets,
      start: start,
      destination: destination,
      busId: busId,
    );
  }

  @override
  Future<void> handlePaymentCallback(Map<String, dynamic> data) async {
    return remoteDataSource.handlePaymentCallback(data);
  }
}
