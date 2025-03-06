import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AccountController extends GetxController {
  var profileImage = RxnString();

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage.value = pickedFile.path;
    }
  }
}
