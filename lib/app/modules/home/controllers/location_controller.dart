import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationController extends GetxController {
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var isLoading = false.obs;
  var message = "Belum ada lokasi".obs;

  Future<void> getLocation() async {
    isLoading.value = true;
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        throw Exception("Layanan lokasi tidak aktif");
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception("Izin lokasi ditolak");
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception("Izin lokasi ditolak permanen");
      }

      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      latitude.value = position.latitude;
      longitude.value = position.longitude;
      message.value =
      "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
    } catch (e) {
      message.value = "Gagal mendapatkan lokasi: $e";
    }
    isLoading.value = false;
  }

  void openInGoogleMaps() {
    final url = "https://www.google.com/maps?q=$latitude,$longitude";
    launchUrl(Uri.parse(url));
  }
}
