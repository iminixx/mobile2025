import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/home_controller.dart';
import '../models/transaction_model.dart';
import 'add_transaction.dart';
import 'edit_transaction.dart';
import 'all_transaction_page.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Keuangan Saya', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBalanceCard(controller),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Transaksi Terbaru",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    TextButton.icon(
                      onPressed: () => Get.to(() => AllTransactionsPage()),
                      icon: Icon(Icons.list, color: Colors.white),
                      label: Text("Lihat Semua", style: TextStyle(color: Colors.white)),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ...controller.transactions
                    .take(3)
                    .map((tx) => _buildTransactionCard(tx, controller))
                    .toList(),
                SizedBox(height: 80), // Jeda agar tidak ketumpuk FAB
              ],
            )),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.to(() => AddTransactionPage()),
        label: Text("Tambah", style: GoogleFonts.poppins(fontSize: 16, color: Colors.white)),
        icon: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  Widget _buildBalanceCard(HomeController controller) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueAccent, Colors.lightBlueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))
        ],
      ),
      padding: EdgeInsets.all(20),
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Saldo",
              style: TextStyle(color: Colors.white70, fontSize: 16)),
          SizedBox(height: 5),
          Text(
            NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ')
                .format(controller.balance.value),
            style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildIncomeExpense(
                  "Pemasukan",
                  controller.income.value.toDouble(),
                  Colors.greenAccent.shade100,
                  Icons.arrow_downward),
              _buildIncomeExpense(
                  "Pengeluaran",
                  controller.expense.value.toDouble(),
                  Colors.redAccent.shade100,
                  Icons.arrow_upward),
            ],
          ),
        ],
      )),
    );
  }

  Widget _buildIncomeExpense(
      String label, double value, Color color, IconData icon) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(color: Colors.white70, fontSize: 12)),
            Text(
              NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ').format(value),
              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildTransactionCard(
      TransactionModel tx, HomeController controller) {
    final formattedAmount =
    NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ').format(tx.amount);
    final formattedDate = DateFormat('dd MMM yyyy').format(tx.date);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 6),
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
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              formattedAmount,
              style: TextStyle(
                  color: tx.isIncome ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 10),
            IconButton(
              icon: Icon(Icons.edit, color: Colors.orangeAccent),
              onPressed: () {
                Get.to(() => EditTransactionPage(
                  transactionId: tx.id,
                  title: tx.title,
                  amount: tx.amount,
                  isIncome: tx.isIncome,
                ));
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.grey),
              onPressed: () {
                controller.deleteTransaction(tx.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
