import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      Get.snackbar("Sukses", "Registrasi berhasil!",
          backgroundColor: Colors.green, colorText: Colors.white);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Gagal", e.message ?? "Terjadi kesalahan",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      Get.snackbar("Sukses", "Login berhasil!",
          backgroundColor: Colors.green, colorText: Colors.white);
      Get.offAllNamed('/main');
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Gagal", e.message ?? "Email atau password salah",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
