import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentRemoteDataSource {
  final http.Client client;

  PaymentRemoteDataSource({required this.client});

  Future<void> initiatePayment({
    required String userId,
    required double amount,
    required int numberOfTickets,
    required String start,
    required String destination,
    required String busId, // Include busId
  }) async {
    final Uri url = Uri.parse('http://192.168.56.1:8000/initiate');

    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': userId,
        'amount': amount,
        'number_of_tickets': numberOfTickets,
        'start': start,
        'destination': destination,
        'bus_id': busId,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to initiate payment');
    }
  }

  Future<String> handlePaymentCallback(Map<String, dynamic> callbackData) async {
    final Uri url = Uri.parse('http://192.168.56.1:8000/callback');

    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(callbackData),
    );
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody.containsKey('qr_code_base64')) {
        return responseBody['qr_code_base64']; 
      } else {
        throw Exception('QR code not found in the response');
      }
    } else {
      throw Exception('Failed to handle callback');
    }
  }
}
