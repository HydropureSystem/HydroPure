import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/routes/app_routes.dart';
import '../app/theme/app_colors.dart';

class BottomNav extends StatelessWidget {

  final int currentIndex;

  const BottomNav({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(

      currentIndex: currentIndex,

      type: BottomNavigationBarType.fixed,

      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.black54,

      onTap: (index) {

        switch (index) {

         
          case 0:
            Get.toNamed(Routes.HOME);
            break;
      
          case 1:
            Get.toNamed(Routes.PEST_DETECTION);
            break;

          case 2:
            Get.toNamed(Routes.AI_CHAT);
            break;

          case 3:
            Get.toNamed(Routes.SETTINGS);
            break;
        }
      },

      items: const [

        BottomNavigationBarItem(
          icon: Icon(Icons.eco),
          label: 'Farm',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.qr_code_scanner),
          label: 'Scan',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.smart_toy_outlined),
          label: 'AI Chat',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}