import 'package:dartz/dartz.dart';
import 'package:transittrack/core/error/failure.dart';
import 'package:transittrack/features/tickets/domain/repository/payment_repository.dart';

class HandleCallbackUseCase {
  final PaymentRepository _paymentRepository;

  HandleCallbackUseCase(this._paymentRepository);

  Future<Either<Failure, String>> call(Map<String, dynamic> callbackData) async {
    try {
      final qrCodeBase64 = await _paymentRepository.handlePaymentCallback(callbackData);
      return Right(qrCodeBase64);  
    } catch (e) {
      return Left(ServerFailure());  
    }
  }
}
