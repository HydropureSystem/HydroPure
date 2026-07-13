import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app/theme/app_colors.dart';

class AnalyticsSummaryCard extends StatelessWidget {
  final int totalProducts;
  final double highestPrice;
  final double averagePrice;
  final String lastUpdate;

  const AnalyticsSummaryCard({
    super.key,
    required this.totalProducts,
    required this.highestPrice,
    required this.averagePrice,
    required this.lastUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.secondary,
          ],
        ),
        borderRadius: BorderRadius.circular(30),
      ),

      child: Column(
        children: [
          _item(
            "Products",
            totalProducts.toString(),
          ),

          const SizedBox(height: 15),

          _item(
            "Highest Price",
            "Rp ${highestPrice.toStringAsFixed(0)}",
          ),

          const SizedBox(height: 15),

          _item(
            "Average Price",
            "Rp ${averagePrice.toStringAsFixed(0)}",
          ),

          const SizedBox(height: 15),

          _item(
            "Last Update",
            lastUpdate,
          ),
        ],
      ),
    );
  }

  Widget _item(
    String title,
    String value,
  ) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,

      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),

        Text(
          value,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}