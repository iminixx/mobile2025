import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../controllers/account_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
                          SizedBox(height: 10),
                          ElevatedButton.icon(
                            onPressed: controller.logout,
                            icon: Icon(Icons.logout),
                            label: Text("Logout"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                          ),
                          SizedBox(height: 20),
                          Divider(),
                          Text("Fitur Sensor-Driven", style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () => Get.toNamed('/camera'),
                            child: Text("Kamera"),
                          ),
                          ElevatedButton(
                            onPressed: () => Get.toNamed('/mic'),
                            child: Text("Mikrofon"),
                          ),
                          ElevatedButton(
                            onPressed: () => Get.toNamed('/speaker'),
                            child: Text("Speaker"),
                          ),
                          ElevatedButton(
                            onPressed: () => Get.toNamed('/location'),
                            child: Text("Location"),
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
