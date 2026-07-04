import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hydropure/app/services/notification_service.dart';
import 'package:hydropure/models/iot_log_model.dart';

class NutritionController extends GetxController {
  final DatabaseReference _ref = FirebaseDatabase.instance.ref(
    'hydroponic/logs',
  );

  final logs = <HydroponicLog>[].obs;
  final isLoading = true.obs;

  DateTime? _lastNotification;

  static const double minTds = 500;
  static const double maxTds = 1200;

  static const double minPh = 5.5;
  static const double maxPh = 6.5;

  static const double minTemp = 18;
  static const double maxTemp = 28;

  @override
  void onInit() {
    super.onInit();
    listenLogs();
  }

  void listenLogs() {
    _ref.onValue.listen((event) {
      final value = event.snapshot.value;

      if (value == null) {
        logs.clear();
        isLoading.value = false;
        return;
      }

      final Map<dynamic, dynamic> data = value as Map<dynamic, dynamic>;

      final List<HydroponicLog> temp = [];

      data.forEach((key, value) {
        temp.add(HydroponicLog.fromMap(Map<String, dynamic>.from(value)));
      });

      temp.sort((a, b) => a.timestamp.compareTo(b.timestamp));

      logs.value = temp;

      if (temp.isNotEmpty) {
        checkThreshold(temp.last);
      }
      isLoading.value = false;
      print(logs);
    });
  }

  void checkThreshold(HydroponicLog log) {
    // Hindari spam notif setiap update
    if (_lastNotification != null &&
        DateTime.now().difference(_lastNotification!).inMinutes < 5) {
      return;
    }

    if (log.tds < minTds) {
      NotificationService.showNotification(
        title: "TDS Rendah",
        body: "TDS saat ini ${log.tds.toStringAsFixed(0)} ppm",
      );

      _lastNotification = DateTime.now();
      return;
    }

    if (log.tds > maxTds) {
      NotificationService.showNotification(
        title: "TDS Tinggi",
        body: "TDS saat ini ${log.tds.toStringAsFixed(0)} ppm",
      );

      _lastNotification = DateTime.now();
      return;
    }

    if (log.ph < minPh) {
      NotificationService.showNotification(
        title: "pH Terlalu Asam",
        body: "pH saat ini ${log.ph.toStringAsFixed(2)}",
      );

      _lastNotification = DateTime.now();
      return;
    }

    if (log.ph > maxPh) {
      NotificationService.showNotification(
        title: "pH Terlalu Basa",
        body: "pH saat ini ${log.ph.toStringAsFixed(2)}",
      );

      _lastNotification = DateTime.now();
      return;
    }

    if (log.temperature < minTemp) {
      NotificationService.showNotification(
        title: "Suhu Terlalu Rendah",
        body: "${log.temperature.toStringAsFixed(1)} °C",
      );

      _lastNotification = DateTime.now();
      return;
    }

    if (log.temperature > maxTemp) {
      NotificationService.showNotification(
        title: "Suhu Terlalu Tinggi",
        body: "${log.temperature.toStringAsFixed(1)} °C",
      );

      _lastNotification = DateTime.now();
      return;
    }
  }
}
