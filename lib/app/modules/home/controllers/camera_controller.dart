import 'dart:io';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';

class CameraControllerX extends GetxController {
  late CameraController cameraController;
  RxBool isCameraReady = false.obs;
  RxBool isRecording = false.obs;
  Rx<File?> videoFile = Rx<File?>(null);
  Rx<VideoPlayerController?> videoPlayer = Rx<VideoPlayerController?>(null);

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    cameraController = CameraController(
      cameras.first,
      ResolutionPreset.high,
      enableAudio: true,
    );
    await cameraController.initialize();
    isCameraReady.value = true;
  }

  Future<void> startRecording() async {
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.mp4';

    await cameraController.startVideoRecording();
    isRecording.value = true;
  }

  Future<void> stopRecording() async {
    final file = await cameraController.stopVideoRecording();
    isRecording.value = false;
    videoFile.value = File(file.path);

    final controller = VideoPlayerController.file(videoFile.value!);
    await controller.initialize();
    videoPlayer.value = controller;
    videoPlayer.value!.play();
    update();
  }

  @override
  void onClose() {
    cameraController.dispose();
    videoPlayer.value?.dispose();
    super.onClose();
  }
}
