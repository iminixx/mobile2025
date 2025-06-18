import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../controllers/connectivity_controller.dart';


class AddTransactionPage extends StatelessWidget {
  final HomeController controller = Get.find();
  final ConnectivityController connectivityController = Get.find();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final RxBool isIncome = true.obs;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Transaksi')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Judul Transaksi'),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Nominal'),
            ),
            Row(
              children: [
                Text('Pemasukan'),
                Radio<bool>(
                  value: true,
                  groupValue: isIncome.value,
                  onChanged: (value) => isIncome.value = value!,
                ),
                Text('Pengeluaran'),
                Radio<bool>(
                  value: false,
                  groupValue: isIncome.value,
                  onChanged: (value) => isIncome.value = value!,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text;
                final amount = int.tryParse(amountController.text) ?? 0;

                if (connectivityController.isConnected.value) {
                  controller.addTransaction(title, amount, isIncome.value);
                } else {
                  connectivityController.saveOfflineTransaction({
                    'title': title,
                    'amount': amount,
                    'isIncome': isIncome.value,
                  });
                  Get.snackbar("Tersimpan Offline", "Transaksi akan diunggah saat online.");
                }

                Get.back();
              },
              child: Text('Tambah Transaksi'),
            ),
          ],
        )),
      ),
    );
  }
}
