import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydropure/widgets/plant_card.dart';
import 'package:hydropure/widgets/stats_card.dart';
import '../../../app/routes/app_routes.dart';

import '../../../../widgets/bottom_nav.dart';
import '../../../../widgets/market_price_item.dart';

import '../../../app/theme/app_colors.dart';
import '../controllers/home_controller.dart';
import '../../../widgets/profile_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
                          onTap: () => Get.toNamed(Routes.MARKET_PRICE),
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

              /// MY PLANTS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Plants",
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "View All",
                    style: GoogleFonts.poppins(color: AppColors.primary),
                  ),
                ],
              ),

              SizedBox(height: 20),

              SizedBox(
                height: 290,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.plant.length,
                  itemBuilder: (context, index) {
                    final plant = controller.plant[index];

                    return PlantCard(
                      image: plant['image']!,
                      title: plant['name']!,
                      days: plant['days']!,
                    );
                  },
                ),
              ),
              SizedBox(height: 30),

              /// MARKET PRICE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Market Prices",
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.MARKET_PRICE),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Live Trend",
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),

                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: controller.getMarketPrices(),
                  builder: (context, snapshot) {
                    /// LOADING
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    /// TIDAK ADA DATA
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text("Belum ada data harga"));
                    }

                    final docs = snapshot.data!.docs;

                    return Column(
                      children: docs.map((doc) {
                        // ignore: unnecessary_cast
                        final data = doc.data() as Map<String, dynamic>;

                        /// NAMA SAYUR
                        final String title = (data['nama'] ?? '-').toString();

                        /// AMBIL HARGA
                        /// contoh:
                        /// "3.000" -> "3000"
                        final String rawPriceStr = (data['harga'] ?? '0')
                            .toString()
                            .replaceAll('Rp', '')
                            .replaceAll('.', '')
                            .replaceAll(' ', '')
                            .trim();

                        /// STRING -> INT
                        final int price = int.tryParse(rawPriceStr) ?? 0;

                        /// MAX HARGA
                        const int maxPrice = 100000;

                        /// PROGRESS BAR
                        double progress = price / maxPrice;

                        /// LIMIT MAX 1.0
                        if (progress > 1) {
                          progress = 1;
                        }

                        /// LIMIT MIN 0
                        if (progress < 0) {
                          progress = 0;
                        }

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 18),

                          child: MarketPriceItem(
                            /// NAMA
                            title: title,

                            /// FORMAT TAMPILAN HARGA
                            price: "${data['harga']}",

                            /// VALUE PROGRESS
                            value: progress,
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
