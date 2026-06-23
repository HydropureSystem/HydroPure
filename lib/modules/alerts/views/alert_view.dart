// lib/app/modules/alerts/views/alert_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydropure/app/theme/app_colors.dart';
import 'package:hydropure/widgets/profile_button.dart';
import '../../../../widgets/bottom_nav.dart';
import '../controllers/alert_controller.dart';

class AlertView extends GetView<AlertController> {
  const AlertView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color(0xFFF5F5F5),
      bottomNavigationBar: const BottomNav(
      currentIndex: 3,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// HEADER
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "HydroPure",
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const CircleAvatar(
                    child: ProfileButton(),
                  )
                ],
              ),

              const SizedBox(height: 30),

              /// TITLE
              Text(
                "Notifications",
                style: GoogleFonts.poppins(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "Stay updated with your hydroponic system’s vital stats.",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 24),

              /// PRIORITY CARD
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.blue,
                    width: 1,
                  ),
                ),

                child: Column(
                  children: [

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0B5D3B),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.science_outlined,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [

                                  Text(
                                    "PRIORITY TASK",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2,
                                      fontSize: 13,
                                      color: const Color(0xFF0B5D3B),
                                    ),
                                  ),

                                  Text(
                                    "Just now",
                                    style: GoogleFonts.poppins(
                                      color: Colors.black54,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 10),

                              Text(
                                "Time to add nutrients\nfor Batch A",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),

                              const SizedBox(height: 10),

                              Text(
                                "Sensors indicate nutrient levels have dropped below the 800ppm threshold.",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [

                        Expanded(
                          child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0B5D3B),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                "Complete Action",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade400,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                "Details",
                                style: GoogleFonts.poppins(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 28),

              /// SETTINGS
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(22),
                ),

                child: Column(
                  children: [

                    Obx(
                      () => SwitchListTile(
                        value: controller.criticalAlert.value,
                        onChanged: (value) {
                          controller.criticalAlert.value = value;
                        },
                        activeThumbColor: const Color(0xFF0B5D3B),
                        title: const Text("Critical System Alerts"),
                        subtitle: const Text(
                          "Pump failure, leak detection, and power loss.",
                        ),
                      ),
                    ),

                    Obx(
                      () => SwitchListTile(
                        value: controller.maintenanceReminder.value,
                        onChanged: (value) {
                          controller.maintenanceReminder.value = value;
                        },
                        activeThumbColor: const Color(0xFF0B5D3B),
                        title: const Text("Maintenance Reminders"),
                        subtitle: const Text(
                          "Nutrient cycles, pH balancing, and cleaning.",
                        ),
                      ),
                    ),

                    Obx(
                      () => SwitchListTile(
                        value: controller.marketingNews.value,
                        onChanged: (value) {
                          controller.marketingNews.value = value;
                        },
                        activeThumbColor: const Color(0xFF0B5D3B),
                        title: const Text("Marketing & News"),
                        subtitle: const Text(
                          "Community updates and market trends.",
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}