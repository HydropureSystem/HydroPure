import 'package:get/get.dart';

class DetectionResultController extends GetxController {
  RxString pestName = "Tidak Terdeteksi".obs;
  RxString description =
      "Tanaman tampak sehat atau hama tidak dikenali oleh sistem.".obs;
  RxString severity = "Normal".obs;

  // Menyimpan data koordinat asli dari Flask jika sewaktu-waktu dibutuhkan di UI View
  RxList<dynamic> predictions = <dynamic>[].obs;

  List<Map<String, dynamic>> recommendations = [];

  @override
  void onInit() {
    super.onInit();

    // BACA DATA DARI ARGUMENTS GETX YANG DIKIRIM CONTROLLER SEBELUMNYA
    if (Get.arguments != null) {
      final data = Get.arguments as Map<String, dynamic>;
      predictions.value = data['predictions'] ?? [];

      if (predictions.isNotEmpty) {
        // Mengambil prediksi pertama dengan tingkat confidence tertinggi
        var topPrediction = predictions[0];

        // Ambil data 'class_name' dan 'confidence' dari JSON backend Anda
        String name = topPrediction['class_name'] ?? "Hama Tanpa Nama";
        double conf = (topPrediction['confidence'] ?? 0.0) * 100;

        pestName.value = name;
        severity.value =
            "Critical"; // Anda bisa buat kondisi if berdasarkan jenis hamanya nanti
        description.value =
            "Hama '$name' terdeteksi dengan tingkat akurasi ${conf.toStringAsFixed(1)}%. "
            "Segera lakukan tindakan isolasi mandiri pada modul hidroponik terkait.";

        // Rekomendasi dinamis berdasarkan nama hama dari database lokal Flutter Anda
        _generateRecommendations(name);
      }
    }
  }

  // Fungsi opsional untuk mengubah rekomendasi otomatis berdasarkan nama hama yang tertangkap Flask
  void _generateRecommendations(String name) {
    recommendations = [
      {
        "title": "Isolate Module",
        "desc":
            "Segera pisahkan tanaman yang terkena hama '$name' dari instalasi utama HydroPure Anda.",
        "icon": "eco",
      },
      {
        "title": "Pengendalian Hama",
        "desc":
            "Gunakan semprotan organik atau Neem Oil sesuai dengan dosis penanganan hama $name.",
        "icon": "water",
      },
    ];
  }
}
