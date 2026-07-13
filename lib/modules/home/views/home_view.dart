import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydropure/widgets/market_price_card.dart';
import 'package:hydropure/widgets/stats_card.dart';
import '../../../app/routes/app_routes.dart';

import '../../../../widgets/bottom_nav.dart';

import '../../../app/theme/app_colors.dart';
import '../controllers/home_controller.dart';
import '../../../widgets/profile_button.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  // removed stray `plant` getter; use `controller.plant` instead

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: BottomNav(currentIndex: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
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
                  CircleAvatar(child: ProfileButton()),
                ],
              ),

              SizedBox(height: 30),

              /// WELCOME
              Obx(
                () => RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(color: Colors.black),
                    children: [
                      TextSpan(
                        text: "Welcome ,\n",
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: controller.userName.value, // Data dari controller
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// STATUS CARD
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.lightGreen,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.eco, color: AppColors.primary),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "System Status: Optimal\nAll 14 growth modules are performing within parameters.",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30),

              /// NUTRITION STATS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Realtime Stats",
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Obx(
                () => Text(
                  'Last Updated ${controller.latestLog["timestamp"] ?? 'N/A'}',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              SizedBox(height: 20),

              Column(
                spacing: 20,
                children: [
                  Row(
                    spacing: 20,
                    children: [
                      Expanded(
                        flex: 5,
                        child: SizedBox(
                          height: 100,
                          child: Obx(
                            () => StatsCard(
                              title: "Tds",
                              value: controller.latestLog['tds']!
                                  .roundToDouble(),
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 5,
                        child: SizedBox(
                          height: 100,
                          child: Obx(
                            () => StatsCard(
                              title: "Ph",
                              value: controller.latestLog['ph']!
                                  .roundToDouble(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 20,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 100,
                          child: Obx(
                            () => StatsCard(
                              title: "Temperature",
                              value: controller.latestLog['temperature']!
                                  .roundToDouble(),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Get.toNamed(Routes.NUTRITIONS),
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "View More",
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Obx(() {
                
                    if (controller.topProducts.isEmpty) {
                      return Center(
                        child: Text(
                          "No market data available",
                          style: GoogleFonts.poppins(),
                        ),
                      );
                    }
                
                    return Column(
                      children: [
                
                        /// LAST UPDATE
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                Icon(
                  Icons.update,
                  color: AppColors.primary,
                ),
                
                const SizedBox(width: 10),
                
                Expanded(
                  child: Text(
                    "Last Update : ${controller.marketUpdate.value}",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                    ),
                  ),
                ),
                            ],
                          ),
                        ),
                
                        const SizedBox(height: 20),
                
                        /// TOP 5 PRODUCTS
                        ...controller.topProducts.map((item) {
                          return Padding(
                            padding: const EdgeInsets.only(
                bottom: 18,
                            ),
                            child: MarketPriceCard(
                title: item.namaProduk,
                price: item.hargaText,
                value: item.progress,
                            ),
                          );
                        }).toList(),
                
                        const SizedBox(height: 10),
                
                        /// BUTTON DETAIL
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                Get.toNamed(
                  Routes.MARKET_PRICE,
                );
                            },
                
                            icon: const Icon(
                Icons.analytics_outlined,
                            ),
                
                            label: const Text(
                "View Full Analytics",
                            ),
                
                            style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                
                backgroundColor:
                    AppColors.primary,
                
                foregroundColor:
                    Colors.white,
                
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20),
                ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
            ],
          ),
        ),  
      ),
    );
  }
}