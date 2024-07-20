import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/payment/payment_model.dart';
import '../model/payment/payment_response.dart';


class PaymentService {
  final String _apiUrl = 'https://api.moyasar.com/v1/payments';
  final String _secretKey = 'sk_test_3xh2VbDsw4TyV6q3cU83rHhTqc8UrYD5FqNns36K';

  Future<PaymentResponse> createPayment(PaymentModel paymentModel) async {
    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {
        'Authorization': 'Basic ${base64Encode(utf8.encode('$_secretKey:'))}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(paymentModel.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return PaymentResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create payment');
    }
  }
}
