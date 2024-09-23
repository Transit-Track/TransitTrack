import 'package:mockito/annotations.dart';
import 'package:transittrack/features/driver/domain/repository/driver_repository.dart';
import 'package:http/http.dart' as http;

@GenerateMocks(
  [
    DriverRepository
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)

void main() {}