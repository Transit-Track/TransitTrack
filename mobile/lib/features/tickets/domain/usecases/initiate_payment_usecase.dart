import 'package:dartz/dartz.dart';
import 'package:transittrack/core/error/failure.dart';
import 'package:transittrack/features/tickets/domain/repository/payment_repository.dart';

class InitiatePaymentParams {
  final String userId;
  final double amount;
  final int numberOfTickets;
  final String startLocation;
  final String destination;
  final String busId;

  InitiatePaymentParams({
    required this.userId,
    required this.amount,
    required this.numberOfTickets,
    required this.startLocation,
    required this.destination,
    required this.busId,
  });
}

class InitiatePaymentUsecase {
  final PaymentRepository repository;

  InitiatePaymentUsecase(this.repository);

  Future<void> call(InitiatePaymentParams params) async {
    return await repository.initiatePayment(
      userId: params.userId,
      amount: params.amount,
      numberOfTickets: params.numberOfTickets,
      start: params.startLocation,
      destination: params.destination,
      busId: params.busId,
    );
  }
}
