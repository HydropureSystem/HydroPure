import 'package:get/get.dart';

class PlantsController extends GetxController {
  final plantsName = "Selada".obs;

  final progress = 65.obs;
  final ph = 6.2.obs;
  final ppm = 850.obs;
  final humidity = 65.obs;
  final waterTemp = 22.obs;

  final maintenanceLogs = [
    {
      "date": "Today",
      "description":
          "Nutrient refill completed. System reservoir at 100% capacity.",
    },
    {
      "date": "2 days ago",
      "description": "pH balanced from 6.8 to 6.2. Added pH Down solution.",
    },
    {
      "date": "4 days ago",
      "description":
          "System cleaning performed. All hydroponic channels inspected.",
    },
  ].obs;
}
