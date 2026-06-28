import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hydropure/app/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeController extends GetxController {
  // ignore: unused_field
  final AuthService _authService = AuthService();

  // Variabel reaktif untuk menyimpan nama user
  var userName = "Guest".obs;

  // Sample plant data for the "My Plants" list. Replace with real data source as needed.
  final List<Map<String, String>> plant = [
    {'image': 'assets/images/plant1.png', 'name': 'Lettuce', 'days': '14'},
    {'image': 'assets/images/plant2.png', 'name': 'Basil', 'days': '7'},
  ];

  final latestLog = <String, dynamic>{
    'ph': 0.0,
    'temperature': 0.0,
    'tds': 0.0,
    'timestamp': '',
  }.obs;

  @override
  void onInit() {
    super.onInit();
    getUserData();
    listenLatestRealtimeLog();
  }

  void getUserData() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // ignore: avoid_print
      print(user);
      // Ambil displayName dari Google Account, jika null pakai email
      userName.value =
          user.displayName ?? user.email?.split('@')[0] ?? "Farmer";
    }
  }

  void listenLatestRealtimeLog() {
    final dbRef = FirebaseDatabase.instance.ref('hydroponic/latest');

    dbRef.onValue.listen(
      (event) {
        final snapshot = event.snapshot;
        final value = snapshot.value;
        if (value is Map<Object?, Object?>) {
          latestLog.value = {
            'ph': _parseDouble(value['ph']),
            'temperature': _parseDouble(value['temperature']),
            'tds': _parseDouble(value['tds']),
            'timestamp': value['timestamp']?.toString() ?? '',
          };
        }
      },
      onError: (error) {
        // ignore: avoid_print
        print('Realtime DB error: $error');
      },
    );

  }

  double _parseDouble(Object? value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    }
    return 0.0;
  }

  // Import firebase core di bagian paling atas

  Stream<QuerySnapshot<Map<String, dynamic>>> getMarketPrices() {
    return FirebaseFirestore.instanceFor(
      app: Firebase.app(), // Ambil app yang sudah di-initialize di main.dart
      databaseId: 'hydropure', // Pastikan ID ini sama dengan di Console
    ).collection('realtime_market').snapshots();
  }
}
