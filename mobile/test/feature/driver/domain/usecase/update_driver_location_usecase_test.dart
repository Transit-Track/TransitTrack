import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:transittrack/features/driver/domain/usecase/update_driver_location_usecase.dart';

import '../../helper/driver_test_helper.mocks.dart';

void main() {
  late UpdateDriverLocationUsecase updateDriverLocationUseCase;
  late MockDriverRepository mockDriverRepository;

  setUp(() {
    mockDriverRepository = MockDriverRepository();
    updateDriverLocationUseCase =
        UpdateDriverLocationUsecase(repository: mockDriverRepository);
  });

  double tLatitude = 0.0;
  double tLongitude = 0.0;

  String tDriverLocation = 'Driver location updated';

  test(
    'should update driver location',
    () async {
      // arrange
      when(mockDriverRepository.updateDriverLocation(
             latitude: tLatitude, longitude: tLongitude))
          .thenAnswer((_) async => Right(tDriverLocation));

      // act
      final result = await updateDriverLocationUseCase( UpdateDriverLocationParams(
          latitude:  tLatitude, longitude: tLongitude));

      // assert
      expect(result, Right(tDriverLocation));
    },
  );
}
