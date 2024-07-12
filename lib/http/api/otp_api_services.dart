import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../constant.dart';

class OtpApiServices{
  static Future<http.Response> sendOtp(String number) async {
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "userName": messageUserNameKey,
      "number": number,
      "userSender": messageSenderNameKey,
      "apiKey": messageApiKey,
      "lang": "En"
    });

    final response = await http.post(Uri.parse(sendOtpApiRequest),
        headers: headers, body: body);
    return response;
  }

  static Future<http.Response> verifyCode(String code, int id) async {
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "userName": messageUserNameKey,
      "apiKey": messageApiKey,
      "lang": "En",
      "code": code,
      "id": id,
      "userSender": messageSenderNameKey
    });

    final response = await http.post(Uri.parse(verifyOtpApiRequest),
        headers: headers, body: body);
    return response;
  }
}