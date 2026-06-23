// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../app/routes/app_routes.dart';
import '../../../app/services/auth_service.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final AuthService authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instanceFor(
    app: Firebase.app(), // Ambil app yang sudah di-initialize di main.dart
    databaseId: 'hydropure', // Pastikan ID ini sama dengan di Console
  );
  RxBool isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();

    passwordController.dispose();

    super.onClose();
  }

  Future<void> login() async {
    final email = emailController.text.trim();

    final password = passwordController.text.trim();

    /// VALIDASI EMAIL
    if (!GetUtils.isEmail(email)) {
      Get.snackbar("Invalid Email", "Masukkan email valid");
      print('invalid email');
      return;
    }

    /// VALIDASI PASSWORD
    if (password.isEmpty) {
      print('pasword empty');
      Get.snackbar("Password Empty", "Password wajib diisi");

      return;
    }

    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
    try {
      print('Starting login...');
      isLoading.value = true;

      /// LOGIN FIREBASE
      await authService.login(email: email, password: password);

      final doc = await _firestore.collection('otp_codes').doc(email).get();

      final verified = doc['verified'] ?? false;

      /// CHECK VERIFIED
      if (!verified) {
        Get.defaultDialog(
          title: "Email Belum Diverifikasi",

          middleText: "Silakan verifikasi OTP terlebih dahulu.",

          textConfirm: "OK",

          confirmTextColor: Colors.white,

          onConfirm: () {
            Get.back();
          },
        );

        return;
      }

      /// CLEAR CONTROLLER
      emailController.clear();

      passwordController.clear();
      Get.back();
      Get.snackbar("Success", "Login berhasil");

      /// PINDAH KE HOME
      Get.offAllNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      String message = e.message.toString();

      if (e.code == 'user-not-found') {
        message = "Email tidak ditemukan";
      } else if (e.code == 'wrong-password') {
        message = "Password salah";
      } else if (e.code == 'invalid-credential') {
        message = "Email atau password salah";
      }

      Get.snackbar("Login Failed", message);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      isLoading.value = true;

      await authService.signInWithGoogle();

      Get.snackbar("Success", "Login dengan Google berhasil");

      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.snackbar("Google Sign In Failed", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> forgotPassword() async {
    final email = emailController.text.trim();

    /// VALIDASI EMAIL
    if (!GetUtils.isEmail(email)) {
      Get.snackbar("Invalid Email", "Masukkan email yang valid");

      return;
    }

    try {
      isLoading.value = true;

      await authService.resetPassword(email: email);

      Get.defaultDialog(
        title: "Reset Password",

        middleText:
            "Link reset password telah dikirim ke:\n\n$email\n\n"
            "Silakan:\n"
            "1. Buka email\n"
            "2. Cek folder Inbox/Spam\n"
            "3. Klik link reset password\n"
            "4. Buat password baru\n"
            "5. Login kembali",

        textConfirm: "OK",

        confirmTextColor: Colors.white,

        onConfirm: () {
          Get.back();
        },
      );
    } on FirebaseAuthException catch (e) {
      String message = "Terjadi kesalahan";

      if (e.code == 'user-not-found') {
        message = "Email tidak ditemukan";
      }

      Get.snackbar("Reset Failed", message);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
