import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:transittrack/core/error/failure.dart';

abstract class DriverRemoteDataSource {
  Future<String> updateDriverLocation({
    required double latitude,
    required double longitude,
    required String token,
  });
}

class DriverRemoteDataSourceImpl implements DriverRemoteDataSource {
  final http.Client client;

  DriverRemoteDataSourceImpl({required this.client});

  final baseUrl = 'http://192.168.132.143:8000';

  @override
  Future<String> updateDriverLocation(
      {required double latitude,
      required double longitude,
      required String token}) async {
    final response = await client.put(
      Uri.parse('$baseUrl/driver'),
      body: json.encode({
        'latitude': latitude,
        'longitude': longitude,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      return 'Success';
    } else {
      throw ServerFailure();
    }
  }
}
