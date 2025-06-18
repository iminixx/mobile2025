import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controllers/home_controller.dart';

class EditTransactionPage extends StatelessWidget {
  final String transactionId;
  final String title;
  final int amount;
  final bool isIncome;

  EditTransactionPage({
    required this.transactionId,
    required this.title,
    required this.amount,
    required this.isIncome,
  });

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    _titleController.text = title;
    _amountController.text = amount.toString();
    RxBool _isIncome = isIncome.obs;

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Transaksi"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Judul'),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Jumlah'),
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                Obx(() => Switch(
                  value: _isIncome.value,
                  onChanged: (val) {
                    _isIncome.value = val;
                  },
                )),
                Obx(() => Text(_isIncome.value ? 'Pemasukan' : 'Pengeluaran'))
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final updatedTitle = _titleController.text;
                final updatedAmount = int.tryParse(_amountController.text) ?? 0;

                if (updatedTitle.isNotEmpty && updatedAmount > 0) {
                  await FirebaseFirestore.instance
                      .collection('transactions')
                      .doc(transactionId)
                      .update({
                    'title': updatedTitle,
                    'amount': updatedAmount,
                    'isIncome': _isIncome.value,
                  });

                  controller.fetchTransactions(); // Refresh data
                  Get.back(); // Kembali ke HomePage
                }
              },
              child: Text('Simpan Perubahan'),
            )
          ],
        ),
      ),
    );
  }
}
