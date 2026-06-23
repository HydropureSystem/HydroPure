import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      "http://127.0.0.1:2000"; // Ganti dengan URL backend Anda
  //"http://10.0.2.2:8000"; // Gunakan IP ini untuk emulator Android

  /// SEND OTP
  Future<bool> sendOtp({required String email}) async {
    final response = await http.post(
      Uri.parse("$baseUrl/send-otp"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode({"email": email}),
    );

    return response.statusCode == 200;
  }

  /// VERIFY OTP
  Future<bool> verifyOtp({required String email, required String otp}) async {
    final response = await http.post(
      Uri.parse("$baseUrl/verify-otp"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode({"email": email, "otp": otp}),
    );

    return response.statusCode == 200;
  }
}
