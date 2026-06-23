import 'package:get/get.dart';

import '../controllers/plants_controller.dart';

class PlantsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PlantsController());
  }
}
