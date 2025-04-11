import 'package:get/get.dart';
import '../models/coin_model.dart';
import '../services/coin_service.dart';

class CoinController extends GetxController {
  var coins = <CoinModel>[].obs;
  var isLoading = false.obs;
  final CoinService _service = CoinService();

  @override
  void onInit() {
    fetchCoins();
    super.onInit();
  }

  void fetchCoins() async {
    try {
      isLoading.value = true;
      coins.value = await _service.fetchCoins();
    } finally {
      isLoading.value = false;
    }
  }
}
