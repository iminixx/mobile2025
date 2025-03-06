import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../controllers/account_controller.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AccountController controller = Get.put(AccountController());

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleChildScrollView(
                child: SizedBox(width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Obx(() => CircleAvatar(
                            radius: 60,
                            backgroundImage: controller.profileImage.value != null
                                ? FileImage(File(controller.profileImage.value!))
                                : AssetImage("assets/default_avatar.png") as ImageProvider,
                          )),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: controller.pickImage,
                            child: Text("Ganti Foto Profil"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
