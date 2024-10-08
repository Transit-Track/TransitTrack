import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:transittrack/core/constants/constants.dart';
import 'package:transittrack/core/error/failure.dart';

abstract class DriverRemoteDataSource {
  Future<String> updateDriverLocation({
    required double latitude,
    required double longitude,
    required String token,
  });
  Future<String> getNextRoute({required int busId});
}

class DriverRemoteDataSourceImpl implements DriverRemoteDataSource {
  final http.Client client;

  DriverRemoteDataSourceImpl({required this.client});

  @override
  Future<String> updateDriverLocation(
      {required double latitude,
      required double longitude,
      required String token}) async {
    final response = await client.put(
      Uri.parse('$baseUrl/set_driver_location'),
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

  @override
  Future<String> getNextRoute({required int busId}) async {
    final response = await client.get(
      Uri.parse('$baseUrl/next_route').replace(queryParameters: {
        'bus_id': busId.toString(),
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body)['route'];
    } else {
      throw ServerFailure();
    }
  }
}
