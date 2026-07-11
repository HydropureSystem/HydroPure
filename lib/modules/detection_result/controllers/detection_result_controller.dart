import 'package:get/get.dart';

class DetectionResultController extends GetxController {

  late String imagePath;

  late Map<String, dynamic> result;

  RxString pestName = "".obs;
  RxString severity = "".obs;
  RxString description = "".obs;
  RxDouble confidence = 0.0.obs;

  List<Map<String, dynamic>> recommendations = [];

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;

    imagePath = args["imagePath"];

    result = args["result"];

    if (result["detections"] != null &&
        result["detections"].isNotEmpty) {

      final detection = result["detections"][0];

      pestName.value = detection["class"];

      confidence.value =
          (detection["confidence"] as num).toDouble();

      severity.value =
          confidence.value > 0.8
              ? "Critical"
              : "Warning";

      description.value =
          "Hama ${pestName.value} berhasil terdeteksi dengan confidence ${(confidence.value * 100).toStringAsFixed(2)}%.";

      recommendations = [
        {
          "title": "Remove infected leaves",
          "desc":
              "Buang daun yang telah terserang hama.",
          "icon": "eco",
        },
        {
          "title": "Spray Organic Pesticide",
          "desc":
              "Gunakan pestisida organik sesuai dosis.",
          "icon": "water",
        }
      ];
    }

    update();
  }
}