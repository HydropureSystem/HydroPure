import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hydropure/models/market_items.dart';
import 'package:hydropure/providers/market_provider.dart';

class MarketPriceController extends GetxController {
  final provider = MarketProvider();

  RxList<MarketItem> products = <MarketItem>[].obs;

  RxBool loading = true.obs;

  RxString lastUpdate = ''.obs;

  @override
  void onInit() {
    loadData();

    super.onInit();
  }

  Future<void> loadData() async {
    loading.value = true;

    final response = await provider.getMarketTrend();

    lastUpdate.value = response.data['last_update'];

    products.assignAll(
      (response.data['data'] as List)
          .map((e) => MarketItem.fromJson(e))
          .toList(),
    );

    loading.value = false;
  }

  double get highestPrice {
    if (products.isEmpty) return 0;

    return products
        .map((e) => e.harga)
        .reduce((a, b) => a > b ? a : b)
        .toDouble();
  }

  double get averagePrice {
    if (products.isEmpty) return 0;

    final total = products.fold(0, (sum, item) => sum + item.harga);

    return total / products.length;
  }
}
