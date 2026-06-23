import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hydropure/app/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart'; 

class HomeController extends GetxController {
  // ignore: unused_field
  final AuthService _authService = AuthService();
  
  // Variabel reaktif untuk menyimpan nama user
  var userName = "Guest".obs;

  // ignore: strict_top_level_inference
  get plant => null;

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  void getUserData() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // ignore: avoid_print
      print (user);
      // Ambil displayName dari Google Account, jika null pakai email
      userName.value = user.displayName ?? user.email?.split('@')[0] ?? "Farmer";
    }
  }

  // Import firebase core di bagian paling atas

Stream<QuerySnapshot<Map<String, dynamic>>> getMarketPrices() {
  return FirebaseFirestore.instanceFor(
    app: Firebase.app(), // Ambil app yang sudah di-initialize di main.dart
    databaseId: 'hydropure', // Pastikan ID ini sama dengan di Console
  ).collection('realtime_market').snapshots();
}
}