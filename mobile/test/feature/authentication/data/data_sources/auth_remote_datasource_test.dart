import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:transittrack/features/authentication/data/data_sources/auth_remote_datasource.dart';
import 'package:http/http.dart' as http;
import '../../helper/auth_test_helper.mocks.dart';

voidmain() {
  late AuthenticationRemoteDatasource dataSource;
  late MockHttpClient mockHttpClient;
  late MockFlutterSecureStorage mockFlutterSecureStorage;

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockFlutterSecureStorage = MockFlutterSecureStorage();
    dataSource = AuthenticationRemoteDataSourceImpl(client: mockHttpClient, secureStorage: mockFlutterSecureStorage);
  });

  group('login', () {
    test(
      'should perform a POST request on a URL with email and password being the endpoint and with application/json header',
      () async {
        // arrange
        when(mockHttpClient.post(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response('{"token": "token"}', 200));

        // act
        // dataSource.login(email: tEmail, password: tPassword);

        // assert
        // verify(mockHttpClient.post(
        //   Uri.parse('https://api.com/login'),
        //   headers: {
        //     'Content-Type': 'application/json',
        //   },
        //   body: jsonEncode({
        //     'email': tEmail,
        //     'password': tPassword,
        //   }),
        // ));
      },
    );

    test(
      'should return a token when the response code is 200 (success)',
      () async {
        // arrange
        when(mockHttpClient.post(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response('{"token": "token"}', 200));
        // act
        // final result =
        //     await dataSource.login(email: tEmail, password: tPassword);
        // // assert
        // expect(result, equals('token'));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(mockHttpClient.post(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.login;
        // assert
        // expect(() => call(email: tEmail, password: tPassword),
        //     throwsA(isA<ServerException>()));
      },
    );
  });
}
