import 'package:get/get.dart';
import 'package:hydropure/modules/nutrition_stats/controllers/nutrition_controller.dart';

class NutritionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NutritionController());
  }
}
