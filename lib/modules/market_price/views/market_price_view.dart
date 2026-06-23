import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:hydropure/app/theme/app_colors.dart';
import 'package:hydropure/widgets/bottom_nav.dart';
import 'package:hydropure/widgets/profile_button.dart';
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              /// HEADER
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                children: [

                  /// LEFT SIDE
                  Row(
                    children: [

                      /// BACK BUTTON
                      GestureDetector(

                        onTap: () {
                          Get.offAllNamed(Routes.HOME);
                        },

                        child: Container(

                          padding: const EdgeInsets.all(10),

                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius:
                                BorderRadius.circular(16),
                          ),

                          child: Icon(
                            Icons.arrow_back_ios_new,

                            color: AppColors.primary,
                            size: 20,
                          ),
                        ),
                      ),

                      const SizedBox(width: 14),

                      /// TITLE
                      Text(
                        "HydroPure",

                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),

                  /// PROFILE
                  CircleAvatar(
                    child: ProfileButton(),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              /// TITLE
              Text(
                "Market Prices",

                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              /// CONTENT
              Obx(() {

                /// Loading
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                /// Empty Data
                if (controller.vegetableList.isEmpty) {
                  return Center(
                    child: Text(
                      "Belum ada data harga",

                      style: GoogleFonts.poppins(
                        fontSize: 16,
                      ),
                    ),
                  );
                }

                /// Data List
                return ListView.builder(

                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(),

                  itemCount:
                      controller.vegetableList.length,

                  itemBuilder: (context, index) {

                    final item =
                        controller.vegetableList[index];

                    return Container(

                      margin: const EdgeInsets.only(
                        bottom: 18,
                      ),

                      padding: const EdgeInsets.all(18),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius:
                            BorderRadius.circular(24),
                      ),

                      child: Row(
                        children: [

                          /// ICON
                          Container(
                            padding:
                                const EdgeInsets.all(14),

                            decoration: BoxDecoration(
                              color:
                                  AppColors.lightGreen,

                              borderRadius:
                                  BorderRadius.circular(18),
                            ),

                            child: Icon(
                              Icons.shopping_basket,

                              color: AppColors.primary,
                            ),
                          ),

                          const SizedBox(width: 16),

                          /// TEXT
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,

                              children: [

                                Text(
                                  item['nama'] ??
                                      'Tanpa Nama',

                                  style:
                                      GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  item['sumber'] ??
                                      'Pasar',

                                  style:
                                      GoogleFonts.poppins(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// PRICE
                          Text(
                            "${item['harga']}",

                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}