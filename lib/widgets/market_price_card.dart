import 'package:flutter/material.dart';

import '../app/theme/app_colors.dart';

class MarketPriceCard extends StatelessWidget {
  final String title;
  final String price;
  final double value;

  const MarketPriceCard({
    super.key,
    required this.title,
    required this.price,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text(title)),
            Text(
              price,
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        Container(
  padding: EdgeInsets.all(18),

  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
  ),

  child: Column(
    children: [

      Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

        children: [
          Expanded(
            child: Text(
              title,
            ),
          ),

          Text(
            price,
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),

      SizedBox(height: 12),

      LinearProgressIndicator(
        value: value,
        borderRadius:
            BorderRadius.circular(10),
      ),
    ],
  ),
)
      ],
    );
  }
}
