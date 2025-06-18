import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/home_controller.dart';
import '../models/transaction_model.dart';

class AllTransactionsPage extends StatelessWidget {
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Semua Transaksi"),
      ),
      body: Obx(() {
        if (controller.transactions.isEmpty) {
          return Center(child: Text("Belum ada transaksi."));
        }
        return ListView.builder(
          itemCount: controller.transactions.length,
          itemBuilder: (context, index) {
            final tx = controller.transactions[index];
            final formattedAmount = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ').format(tx.amount);
            final formattedDate = DateFormat('dd MMM yyyy').format(tx.date);
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: tx.isIncome ? Colors.green : Colors.red,
                  child: Icon(
                    tx.isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                    color: Colors.white,
                  ),
                ),
                title: Text(tx.title, style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(formattedDate),
                trailing: Text(
                  formattedAmount,
                  style: TextStyle(
                    color: tx.isIncome ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
