import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hydropure/app/theme/app_colors.dart';
import 'package:hydropure/widgets/bottom_nav.dart';
import 'package:hydropure/widgets/market_price_card.dart';
import 'package:hydropure/widgets/profile_button.dart';
import 'package:hydropure/widgets/analytics_summary_card.dart';
import 'package:hydropure/widgets/product_grid_card.dart';

import '../../../app/routes/app_routes.dart';
import '../controllers/market_price_controller.dart';

class MarketPriceView extends GetView<MarketPriceController> {
  const MarketPriceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      bottomNavigationBar: BottomNav(currentIndex: 1),

      body: SafeArea(
        child: Obx(() {
          if (controller.loading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return RefreshIndicator(
            onRefresh: controller.loadData,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  /// HEADER
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.offAllNamed(
                                Routes.HOME,
                              );
                            },

                            child: Container(
                              padding:
                                  const EdgeInsets.all(10),

                              decoration: BoxDecoration(
                                color: Colors.white,

                                borderRadius:
                                    BorderRadius.circular(
                                  16,
                                ),
                              ),

                              child: Icon(
                                Icons.arrow_back_ios_new,
                                color:
                                    AppColors.primary,
                                size: 20,
                              ),
                            ),
                          ),

                          const SizedBox(width: 14),

                          Text(
                            "HydroPure",

                            style:
                                GoogleFonts.poppins(
                              fontSize: 32,
                              fontWeight:
                                  FontWeight.bold,
                              color:
                                  AppColors.primary,
                            ),
                          ),
                        ],
                      ),

                      const CircleAvatar(
                        child: ProfileButton(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  /// TITLE
                  Text(
                    "Market Analytics",

                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "Last Update : ${controller.lastUpdate.value}",

                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// SUMMARY CARD
                  AnalyticsSummaryCard(
                    totalProducts:
                        controller.products.length,
                    highestPrice:
                        controller.highestPrice,
                    averagePrice:
                        controller.averagePrice,
                    lastUpdate:
                        controller.lastUpdate.value,
                  ),

                  const SizedBox(height: 30),

                  /// TOP PRODUCTS
                  Text(
                    "Top Products",

                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 20),

                  ListView.builder(
                    shrinkWrap: true,

                    physics:
                        const NeverScrollableScrollPhysics(),

                    itemCount:
                        controller.products.length,

                    itemBuilder: (_, index) {
                      final item =
                          controller.products[index];

                      return Padding(
                        padding:
                            const EdgeInsets.only(
                          bottom: 16,
                        ),

                        child: MarketPriceCard(
                          title:
                              item.namaProduk,

                          price:
                              item.hargaText,

                          value:
                              item.progress,
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 30),

                  /// ALL PRODUCTS
                  Text(
                    "All Products",

                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 20),

                  ProductGridCard(
                    products:
                        controller.products,
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}