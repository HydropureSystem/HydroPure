import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hydropure/app/routes/app_routes.dart';
import 'package:hydropure/app/services/api_service.dart';

import '../../../app/services/auth_service.dart';

class RegisterController extends GetxController {
  final fullNameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final AuthService authService = AuthService();

  RxBool isLoading = false.obs;

  Future<void> register() async {
    final fullName = fullNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (fullName.isEmpty) {
      Get.snackbar("Invalid Name", "Nama lengkap wajib diisi");
      return;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar("Invalid Email", "Masukkan email yang valid");
      return;
    }

    if (password.length < 6) {
      Get.snackbar("Weak Password", "Password minimal 6 karakter");
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar("Password Error", "Password tidak sama");
      return;
    }

    try {
      isLoading.value = true;

      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      print("1. Mulai Register");

      await authService.register(
        username: fullName,
        email: email,
        password: password,
      );

      print("2. Firebase selesai");

      final success = await ApiService().sendOtp(email: email);

      print("HASIL OTP = $success");

      if (!success) {
        throw Exception("Gagal mengirim OTP.");
      }

      print("4. Sebelum pindah halaman");

      fullNameController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();

      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      Get.offAllNamed(Routes.OTP, arguments: email);
    } on FirebaseAuthException catch (e) {
      String message = "Terjadi kesalahan.";

      switch (e.code) {
        case "email-already-in-use":
          message = "Email sudah digunakan.";
          break;
        case "weak-password":
          message = "Password terlalu lemah.";
          break;
        case "invalid-email":
          message = "Email tidak valid.";
          break;
      }

      print("5. Setelah pindah halaman");

      Get.snackbar("Register Failed", message);
    } catch (e, stackTrace) {
      debugPrint("Register Error: $e");
      debugPrintStack(stackTrace: stackTrace);
      Get.snackbar("Register Failed", e.toString());
    } finally {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      isLoading.value = false;
    }
  }

  Future<void> registerWithGoogle() async {
    try {
      isLoading.value = true;

      await authService.signInWithGoogle();

      Get.snackbar("Success", "Login Google berhasil");

      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.snackbar("Google Sign In Failed", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
