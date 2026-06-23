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

    /// VALIDASI FULL NAME
    if (fullName.isEmpty) {
      Get.snackbar("Invalid Name", "Nama lengkap wajib diisi");

      return;
    }

    /// VALIDASI EMAIL
    if (!GetUtils.isEmail(email)) {
      Get.snackbar("Invalid Email", "Masukkan email yang valid");

      return;
    }

    /// VALIDASI PASSWORD
    if (password.length < 6) {
      Get.snackbar("Weak Password", "Password minimal 6 karakter");

      return;
    }

    /// VALIDASI CONFIRM PASSWORD
    if (password != confirmPassword) {
      Get.snackbar("Password Error", "Password tidak sama");

      return;
    }

    try {
      // isLoading.value = true;

      /// REGISTER FIREBASE
      // ignore: unused_local_variable
      final userCredential = await authService.register(
        username: fullName,
        email: email,
        password: password,
      );
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );
      final success = await ApiService().sendOtp(email: email);

      if (success) {
        Get.toNamed(Routes.OTP, arguments: email);
      } else {
        Get.snackbar("Error", "Gagal mengirim OTP");
      }
      Get.back();

      /// CLEAR CONTROLLERS BEFORE NAVIGATION
      fullNameController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();

      // Get.defaultDialog(
      //   barrierDismissible: false,
      //   title: "Verifikasi Email",
      //   middleText:
      //       "Akun berhasil dibuat.\n\n"
      //       "Link verifikasi telah dikirim ke:\n\n$email\n\n"
      //       "Silakan cek email.",
      //   textConfirm: "OK",
      //   confirmTextColor: Colors.white,
      //   onConfirm: () {
      //   }
      // );
      Get.offAllNamed(Routes.OTP, arguments: email);
    } on FirebaseAuthException catch (e) {
      String message = "Terjadi kesalahan";

      if (e.code == 'email-already-in-use') {
        message = "Email sudah digunakan";
      } else if (e.code == 'weak-password') {
        message = "Password terlalu lemah";
      } else if (e.code == 'invalid-email') {
        message = "Format email tidak valid";
      }

      Get.snackbar("Register Failed", message);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
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

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
