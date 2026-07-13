import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hydropure/app/routes/app_routes.dart';
import 'package:hydropure/app/theme/app_colors.dart';
import '../controllers/register_controller.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterController controller = Get.find<RegisterController>();
  
  bool agree = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.background,
        child: Column(
          children: [
            // logo
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
                color: Colors.white,
              ),
              height: 80,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.eco_rounded,
                    size: 42,
                    color: AppColors.primary,
                  ),
                  Text(
                    'HydroPure',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Card(
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
                            'Create Account',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Start your journey toward smart, automated farming today.',
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
                            label: "Full Name",
                            hint: "e.g john Farmer",
                            icon: Icons.person_outline_sharp,
                            controller: controller.fullNameController,
                          ),
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
                          _buildInputField(
                            label: "Confirm",
                            hint: "Password",
                            icon: Icons.shield_outlined,
                            obscure: true,
                            controller: controller.confirmPasswordController,
                          ),
                          _buildTOC(),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              minimumSize: const Size(double.infinity, 56),
                            ),
                            onPressed: () {
                              controller.register();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 12,
                              children: [
                                Text(
                                  "Register Account",
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
                          controller.registerWithGoogle();
                        },

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          spacing: 12,

                          children: [
                            Icon(
                              Icons.g_mobiledata_outlined,
                              color: Colors.black,
                              size: 24,
                            ),

                            Text(
                              "Register With Google",

                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account? ",
                            style: TextStyle(
                              color: Color(0xFF3B3B3B),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextButton(
                            onPressed: () => Get.toNamed(Routes.LOGIN),
                            child: const Text(
                              'Log In',
                              style: TextStyle(
                                color: AppColors.primary,
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
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildInputField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    bool obscure = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),

        const SizedBox(height: 4),

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

              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 18, right: 14),

                child: Icon(icon, size: 28, color: Colors.black),
              ),

              prefixIconConstraints: const BoxConstraints(minWidth: 70),

              hintText: hint,

              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),

              contentPadding: const EdgeInsets.symmetric(vertical: 24),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTOC() {
    return Row(
      children: [
        Checkbox(value: true, onChanged: (value) {}),
        Expanded(
          child: RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'I agree to the ',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: 'Terms of Service',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextSpan(
                  text: ' and ',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: 'Privacy Policy.',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
