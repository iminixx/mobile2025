import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'home_controller.dart';

class ConnectivityController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  final GetStorage storage = GetStorage();

  RxBool isConnected = true.obs;
  StreamSubscription<ConnectivityResult>? _subscription;

  @override
  void onInit() {
    _checkConnection();
    _subscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.onInit();
  }

  void _checkConnection() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    isConnected.value = result != ConnectivityResult.none;
    if (!isConnected.value) {
      Get.snackbar("Koneksi Terputus", "Tidak ada koneksi internet.");
    } else {
      Get.snackbar("Koneksi Terhubung", "Internet tersedia.");
      _uploadPendingData();
    }
  }

  void saveOfflineTransaction(Map<String, dynamic> transaction) {
    List<dynamic> offlineData = storage.read('offline_transactions') ?? [];
    offlineData.add(transaction);
    storage.write('offline_transactions', offlineData);
  }

  void _uploadPendingData() {
    List<dynamic> offlineData = storage.read('offline_transactions') ?? [];
    if (offlineData.isNotEmpty) {
      for (var data in offlineData) {
        final homeController = Get.find<HomeController>();
        homeController.addTransaction(data['title'], data['amount'], data['isIncome']);
      }
      storage.remove('offline_transactions');
    }
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}
