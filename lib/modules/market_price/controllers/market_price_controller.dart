import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class MarketPriceController extends GetxController {
  
  final FirebaseFirestore _firestore = FirebaseFirestore.instanceFor(
    app: Firebase.app(),
    databaseId: 'hydropure',
  );
  
  // Observable list untuk menampung data harga sayur
  var vegetableList = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMarketPrices();
  }

  void fetchMarketPrices() {
  // ignore: avoid_print
  print("DEBUG: Mencoba fetch dari database 'hydropure'...");
  _firestore
      .collection('realtime_market') // GANTI INI sesuai yang ada di foto Console-mu!
      .snapshots()
      .listen((snapshot) {
    // ignore: avoid_print
    print("DEBUG: Berhasil stream! Jumlah dokumen: ${snapshot.docs.length}");
    vegetableList.value = snapshot.docs.map((doc) => doc.data()).toList();
    isLoading(false);
  }, onError: (e) {
  // ignore: avoid_print
  print("DEBUG: Error saat stream: $e");
  });
}
  }