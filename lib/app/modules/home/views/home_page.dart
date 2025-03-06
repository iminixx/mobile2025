import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Keuangan Saya",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              SizedBox(width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => Text("Saldo: Rp ${controller.balance}",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold))),
                        SizedBox(height: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Pemasukan: Rp ${controller.income}",
                                style:
                                    TextStyle(color: Colors.green, fontSize: 16)),
                            Text("Pengeluaran: Rp ${controller.expense}",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text("Transaksi Terbaru",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Expanded(
                child: ListView(
                  children: [
                    _buildTransactionTile("Gaji", 5000000, true),
                    _buildTransactionTile("Makan Siang", -25000, false),
                    _buildTransactionTile("Belanja", -100000, false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionTile(String title, int amount, bool isIncome) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(isIncome ? Icons.arrow_downward : Icons.arrow_upward,
            color: isIncome ? Colors.green : Colors.red),
        title: Text(title),
        subtitle: Text(isIncome ? "Pemasukan" : "Pengeluaran"),
        trailing: Text("Rp $amount",
            style: TextStyle(
                color: isIncome ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
