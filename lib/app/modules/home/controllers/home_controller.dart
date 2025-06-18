import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../models/transaction_model.dart';

class HomeController extends GetxController {
  var transactions = <TransactionModel>[].obs;
  var balance = 0.obs;
  var income = 0.obs;
  var expense = 0.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    fetchTransactions();
  }

  void fetchTransactions() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    _firestore
        .collection('users')
        .doc(uid)
        .collection('transactions') // path baru
        .orderBy('date', descending: true)
        .snapshots()
        .listen((snapshot) {
      transactions.clear();
      int totalIncome = 0;
      int totalExpense = 0;

      for (var doc in snapshot.docs) {
        final data = TransactionModel.fromMap(doc.data(), doc.id);
        transactions.add(data);
        if (data.isIncome) {
          totalIncome += data.amount;
        } else {
          totalExpense += data.amount;
        }
      }

      income.value = totalIncome;
      expense.value = totalExpense;
      balance.value = totalIncome - totalExpense;
    });
  }

  Future<void> addTransaction(String title, int amount, bool isIncome) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('transactions') // path baru
        .add({
      'title': title,
      'amount': amount,
      'isIncome': isIncome,
      'date': DateTime.now().toIso8601String(),
    });
  }

  Future<void> deleteTransaction(String id) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('transactions') // path baru
        .doc(id)
        .delete();
  }

  Future<void> updateTransaction(
      String id, String title, int amount, bool isIncome) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('transactions') // path baru
        .doc(id)
        .update({
      'title': title,
      'amount': amount,
      'isIncome': isIncome,
      'date': DateTime.now().toIso8601String(),
    });
  }
}
