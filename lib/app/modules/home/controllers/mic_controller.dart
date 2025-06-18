import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';

class MicController extends GetxController {
  final SpeechToText _speech = SpeechToText();
  var isListening = false.obs;
  var result = ''.obs;

  Future<void> toggleRecording() async {
    if (!isListening.value) {
      bool available = await _speech.initialize();
      if (available) {
        isListening.value = true;
        _speech.listen(onResult: (val) {
          result.value = val.recognizedWords;
        });
      }
    } else {
      _speech.stop();
      isListening.value = false;
    }
  }
}
