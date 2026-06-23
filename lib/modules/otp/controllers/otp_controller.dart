import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hydropure/app/services/api_service.dart';

class OtpController extends GetxController {
  final otpController = TextEditingController();

  final ApiService apiService = ApiService();

  RxBool isLoading = false.obs;

  RxString email = ''.obs;

  @override
  void onInit() {
    super.onInit();

    /// SAFE ARGUMENT
    final args = Get.arguments;

    if (args != null) {
      email.value = args.toString();
    } else {
      email.value = '';
    }
  }

  Future<void> verifyOtp() async {
    final otp = otpController.text.trim().toString();

    if (otp.length != 6) {
      Get.snackbar("Invalid OTP", "OTP harus 6 digit");

      return;
    }

    final uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      isLoading.value = true;

      final success = await apiService.verifyOtp(
        email: email.value,
        otp: otp,
        uid: uid,
      );

      if (success) {
        Get.defaultDialog(
          title: "Berhasil",

          middleText: "OTP berhasil diverifikasi",

          textConfirm: "Login",

          confirmTextColor: Colors.white,

          onConfirm: () {
            Get.back();

            Get.offAllNamed('/login');
          },
        );
      } else {
        Get.snackbar("Failed", "OTP salah");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    otpController.dispose();

    super.onClose();
  }
}
