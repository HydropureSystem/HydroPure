import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://10.83.92.116:2000";

  Future<bool> sendOtp({required String email}) async {
    try {
      final response = await http
          .post(
            Uri.parse("$baseUrl/send-otp"),
            headers: {
              "Content-Type": "application/json",
            },
            body: jsonEncode({
              "email": email,
            }),
          )
          .timeout(const Duration(seconds: 15));

      print("SEND OTP STATUS : ${response.statusCode}");
      print("SEND OTP BODY   : ${response.body}");

      return response.statusCode == 200;
    } on SocketException {
      throw Exception("Tidak dapat terhubung ke server.");
    } on TimeoutException {
      throw Exception("Server timeout.");
    } catch (e) {
      throw Exception("Send OTP Error : $e");
    }
  }

  Future<bool> verifyOtp({
    required String email,
    required String otp,
    required String uid,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse("$baseUrl/verify-otp"),
            headers: {
              "Content-Type": "application/json",
            },
            body: jsonEncode({
              "email": email,
              "otp": otp,
              "uid": uid,
            }),
          )
          .timeout(const Duration(seconds: 60));

      print("VERIFY STATUS : ${response.statusCode}");
      print("VERIFY BODY   : ${response.body}");

      return response.statusCode == 200;
    } on SocketException {
      throw Exception("Tidak dapat terhubung ke server.");
    } on TimeoutException {
      throw Exception("Server timeout.");
    } catch (e) {
      throw Exception("Verify OTP Error : $e");
    }
  }
}