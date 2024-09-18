import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/annotations.dart';
import 'package:transittrack/features/authentication/domain/repository/authentication_repository.dart';
import 'package:http/http.dart' as http;

@GenerateMocks(
  [
    AuthenticationRepository,
    FlutterSecureStorage,
    
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
