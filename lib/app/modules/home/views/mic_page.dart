import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/mic_controller.dart';

class MicPage extends StatelessWidget {
  final micC = Get.put(MicController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Perekam Suara", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            Text(
              micC.isListening.value ? "Mendengarkan..." : "Tekan untuk mulai bicara",
              style: GoogleFonts.poppins(fontSize: 18, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            TextButton.icon(
              onPressed: micC.toggleRecording,
              icon: Icon(
                micC.isListening.value ? Icons.stop : Icons.mic,
                color: Colors.white,
              ),
              label: Text(
                micC.isListening.value ? "Stop" : "Mulai Bicara",
                style: GoogleFonts.poppins(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                backgroundColor:
                micC.isListening.value ? Colors.redAccent : Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 40),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 4))
                ],
              ),
              child: Text(
                micC.result.value.isNotEmpty
                    ? micC.result.value
                    : "Hasil akan muncul di sini...",
                style: GoogleFonts.poppins(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
