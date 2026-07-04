import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AiChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();

  /// LIST CHAT
  var messages = <Map<String, dynamic>>[
    {"message": "Halo! Saya HydroPure AI 👋", "time": "Now", "isAi": true},
  ].obs;

  /// LOADING
  var isLoading = false.obs;

  /// GANTI DENGAN BACKEND KAMU
  final String baseUrl = "http://127.0.0.1:5000/chat";

  /// SEND MESSAGE
  Future<void> sendMessage() async {
    final text = messageController.text.trim();

    if (text.isEmpty) return;

    /// TAMBAH PESAN USER
    messages.add({"message": text, "time": "Now", "isAi": false});

    messageController.clear();

    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse(baseUrl),

        headers: {"Content-Type": "application/json"},

        body: jsonEncode({"message": text}),
      );
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        messages.add({"message": data["reply"], "time": "Now", "isAi": true});
      } else {
        messages.add({"message": "Server Error", "time": "Now", "isAi": true});
      }
    } catch (e) {
      messages.add({
        "message": "Tidak bisa connect ke backend",
        "time": "Now",
        "isAi": true,
      });
    }

    isLoading.value = false;
  }
}
