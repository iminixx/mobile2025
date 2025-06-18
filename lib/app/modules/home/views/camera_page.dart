import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:video_player/video_player.dart';
import '../controllers/camera_controller.dart';

class CameraPage extends StatefulWidget {
  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final cameraC = Get.put(CameraControllerX());

  @override
  void initState() {
    super.initState();
    cameraC.initCamera();
  }

  @override
  void dispose() {
    cameraC.cameraController.dispose();
    cameraC.videoPlayer.value?.dispose();
    super.dispose();
  }

  String _format(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kamera & Player")),
      backgroundColor: Colors.white,
      body: Obx(() {
        if (!cameraC.isCameraReady.value) {
          return Center(child: CircularProgressIndicator());
        }

        final previewSize = cameraC.cameraController.value.previewSize;
        final previewRatio = previewSize != null
            ? previewSize.height / previewSize.width
            : 16 / 9;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: previewRatio,
                  child: CameraPreview(cameraC.cameraController),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: cameraC.isRecording.value
                      ? Colors.red
                      : Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: cameraC.isRecording.value
                    ? cameraC.stopRecording
                    : cameraC.startRecording,
                icon: Icon(cameraC.isRecording.value ? Icons.stop : Icons.videocam),
                label: Text(cameraC.isRecording.value ? "Stop" : "Rekam"),
              ),
              SizedBox(height: 20),
              if (!cameraC.isRecording.value &&
                  cameraC.videoFile.value != null &&
                  cameraC.videoPlayer.value != null &&
                  cameraC.videoPlayer.value!.value.isInitialized)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Hasil Rekaman",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    AspectRatio(
                      aspectRatio: cameraC.videoPlayer.value!.value.size.width /
                          cameraC.videoPlayer.value!.value.size.height,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: VideoPlayer(cameraC.videoPlayer.value!),
                      ),
                    ),
                    SizedBox(height: 8),
                    VideoProgressIndicator(
                      cameraC.videoPlayer.value!,
                      allowScrubbing: true,
                      colors: VideoProgressColors(
                        playedColor: Colors.blue,
                        bufferedColor: Colors.blue.shade100,
                        backgroundColor: Colors.grey.shade300,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(cameraC.videoPlayer.value!.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow),
                          onPressed: () {
                            if (cameraC.videoPlayer.value!.value.isPlaying) {
                              cameraC.videoPlayer.value!.pause();
                            } else {
                              cameraC.videoPlayer.value!.play();
                            }
                          },
                        ),
                        Text(_format(cameraC.videoPlayer.value!.value.position)),
                        Text(" / "),
                        Text(_format(cameraC.videoPlayer.value!.value.duration)),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        );
      }),
    );
  }
}
