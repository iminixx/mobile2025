import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/coin_controller.dart';

class CoinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CoinController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Harga Crypto", style: GoogleFonts.poppins()),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.coins.isEmpty) {
          return Center(
            child: Text(
              "Tidak ada data coin tersedia.",
              style: GoogleFonts.poppins(),
            ),
          );
        }

        return Column(
          children: [
            // ElevatedButton di bagian atas
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  Get.toNamed('/webview', arguments: "https://coinmarketcap.com/");
                },
                icon: Icon(Icons.language),
                label: Text("Baca Berita Crypto"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            // Daftar coin
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(12),
                itemCount: controller.coins.length,
                itemBuilder: (context, index) {
                  final coin = controller.coins[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      leading: Image.network(
                        coin.image,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        coin.name,
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        "USD ${coin.currentPrice.toStringAsFixed(2)}",
                        style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
