

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hydropure/app/routes/app_routes.dart';
import 'package:hydropure/app/theme/app_colors.dart';

import '../controllers/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
        color: AppColors.background,
        child: Column(
          children: [
            // logo
            Container(
              height: 92,
              width: 92,
              decoration: BoxDecoration(
                color: const Color(0xFF2E6B4E),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(.12),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Icon(
                Icons.eco_rounded,
                size: 42,
                color: Color(0xFFDDF6E7),
              ),
            ),
            SizedBox(height: 16),
            // TITLE
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'Hydro',
                    style: TextStyle(
                      color: Color(0xFF005C4B),
                      fontSize: 42,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  TextSpan(
                    text: 'Pure',
                    style: TextStyle(
                      color: Color(0xFF0F7A5C),
                      fontSize: 42,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4),
            Text(
              "Precision Agriculture for Everyone",
              style: TextStyle(
                color: const Color(0xFF7B7B7B),
                fontWeight: FontWeight.w500,
                fontSize: 16,
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(height: 16),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
                side: const BorderSide(color: Color(0xFF7B7B7B), width: 0.1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 24,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Access your farm\'s health and automation data.',
                          style: TextStyle(
                            // ignore: deprecated_member_use
                            color: Colors.black.withOpacity(0.6),
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),

                    Column(
                      spacing: 16,
                      children: [
                        _buildInputField(
                          label: "Email Address",
                          hint: "farmer@hydropure.com",
                          icon: Icons.mail_outline,

                          controller: controller.emailController,
                        ),
                        _buildInputField(
                          label: "Password",
                          hint: "Password",
                          icon: Icons.lock_outlined,
                          obscure: true,

                          controller: controller.passwordController,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            minimumSize: const Size(double.infinity, 56),
                          ),
                          onPressed: () {
                            controller.login();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 12,
                            children: [
                              Text(
                                controller.isLoading.value
                                    ? "Loading..."
                                    : "Login",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Row(
                      spacing: 14,
                      children: [
                        Expanded(
                          child: Container(height: 1, color: Colors.grey),
                        ),
                        Text(
                          'OR CONTINUE WITH',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Expanded(
                          child: Container(height: 1, color: Colors.grey),
                        ),
                      ],
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade400,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Colors.grey),
                        ),
                        minimumSize: const Size(double.infinity, 56),
                      ),
                      onPressed: () {
                        final controller = Get.find<LoginController>();
                        controller.loginWithGoogle();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 12,
                        children: [
                          Icon(
                            Icons.g_mobiledata_outlined,
                            color: Colors.white,
                            size: 24,
                          ),
                          Text(
                            "Login With Google",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don’t have an account? ",
                          style: TextStyle(
                            color: Color(0xFF3B3B3B),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextButton(
                          onPressed: () => Get.toNamed(Routes.REGISTER),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Color(0xFF0D7A59),
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool obscure = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            if (obscure)
              GestureDetector(
                onTap: () {
                  Get.find<LoginController>().forgotPassword();
                },
                child: const Text(
                  'Forgot Password ?',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.primary,
                  ),
                ),
              ),
          ],
        ),

        SizedBox(height: 4),
        Container(
          height: 68,
          decoration: BoxDecoration(
            color: const Color(0xFFF1F1F1),
            borderRadius: BorderRadius.circular(18),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscure,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xFF111111),
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromARGB(255, 207, 207, 207),

              // BORDER
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(
                  color: Color(0xFFF1F1F1),
                  width: 1,
                ),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(color: AppColors.primary, width: 1.5),
              ),

              // ICON
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 18, right: 14),
                child: Icon(icon, size: 28, color: Colors.black),
              ),

              prefixIconConstraints: const BoxConstraints(minWidth: 70),

              // HINT
              hintText: hint,
              hintStyle: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),

              // REMOVE DEFAULT LINE
              contentPadding: const EdgeInsets.symmetric(vertical: 24),
            ),
          ),
        ),
      ],
    );
  }
}
