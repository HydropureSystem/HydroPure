import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../widgets/bottom_nav.dart';
import '../../../app/theme/app_colors.dart';
import '../controllers/pest_detection_controller.dart';
import 'package:camera/camera.dart';

class PestDetectionView extends GetView<PestDetectionController> {
  const PestDetectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNav(currentIndex: 1),
      body: Stack(
        children: [
          /// BACKGROUND IMAGE (CAMERA PREVIEW)
          positionalBackgroundCamera(),

          /// DARK OVERLAY
          // ignore: deprecated_member_use
          Container(color: Colors.black.withOpacity(0.25)),

          /// MAIN CONTENT UI
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  /// TOP BAR
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _circleButton(
                        icon: Icons.arrow_back_ios_new,
                        onTap: () => Get.back(),
                      ),
                      Column(
                        children: [
                          Text(
                            "Pest Detection",
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.lens,
                                color: Colors.greenAccent,
                                size: 12,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "AI Scanning Active",
                                style: GoogleFonts.poppins(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      _circleButton(
                        icon: Icons.flash_on_outlined,
                        onTap: () {},
                      ),
                    ],
                  ),

                  const Spacer(),

                  /// SCAN FRAME
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 320,
                        height: 420,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.greenAccent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),

                      /// CORNERS
                      Positioned(top: 0, left: 0, child: _corner()),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: _corner(isRight: true),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: _corner(isBottom: true),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: _corner(isBottom: true, isRight: true),
                      ),

                      Positioned(
                        top: -60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 14,
                              ),
                              color: Colors.black45,
                              child: Text(
                                "Align the leaf within the frame\nto detect pests",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  /// MODE SELECTOR
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Obx(
                      () => Row(
                        children: [
                          _modeButton("PHOTO", 0),
                          _modeButton("VIDEO", 1),
                          _modeButton("GALLERY", 2),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// CAMERA BUTTONS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _bottomCircle(Icons.photo_library_outlined),

                      /// SNAP / TAKE PICTURE BUTTON
                      GestureDetector(
                        onTap: () {
                          controller
                              .takePicture(); // Hubungkan ke fungsi jepret & kirim API
                        },
                        child: Container(
                          width: 95,
                          height: 95,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white70, width: 6),
                          ),
                          child: Center(
                            child: Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.primary,
                                  width: 3,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          controller.switchCamera();
                        },
                        child: _bottomCircle(Icons.flip_camera_ios),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          /// LOADING OVERLAY (Mencegah double-tap & memberi feedback saat proses AI Flask)
          Obx(() {
            if (controller.isLoading.value) {
              return Container(
                color: Colors.black54,
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(color: AppColors.primary),
                      const SizedBox(height: 16),
                      Text(
                        "Processing with Local AI...",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  Widget positionalBackgroundCamera() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Obx(() {
        if (!controller.isCameraInitialized.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: CameraPreview(controller.cameraController!),
        );
      }),
    );
  }

  Widget _circleButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 54,
        height: 54,
        decoration: const BoxDecoration(
          color: Colors.white24,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }

  Widget _bottomCircle(IconData icon) {
    return Container(
      width: 65,
      height: 65,
      decoration: const BoxDecoration(
        color: Colors.white24,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 32),
    );
  }

  Widget _corner({bool isRight = false, bool isBottom = false}) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        border: Border(
          top: isBottom
              ? BorderSide.none
              : const BorderSide(color: Colors.greenAccent, width: 5),
          bottom: isBottom
              ? const BorderSide(color: Colors.greenAccent, width: 5)
              : BorderSide.none,
          left: isRight
              ? BorderSide.none
              : const BorderSide(color: Colors.greenAccent, width: 5),
          right: isRight
              ? const BorderSide(color: Colors.greenAccent, width: 5)
              : BorderSide.none,
        ),
      ),
    );
  }

  Widget _modeButton(String title, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          controller.changeMode(index);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: controller.selectedMode.value == index
                ? AppColors.primary
                : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
