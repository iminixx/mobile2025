import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class SpeakerController extends GetxController {
  final player = AudioPlayer();
  var currentIndex = 0.obs;
  var isPlaying = false.obs;

  final List<Map<String, String>> playlist = [
    {
      "title": "Lo-Fi Beat",
      "url": "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
    },
    {
      "title": "Jazz Groove",
      "url": "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3",
    },
    {
      "title": "Chill Vibes",
      "url": "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3",
    },
  ];

  Future<void> loadTrack() async {
    await player.setUrl(playlist[currentIndex.value]['url']!);
    player.play();
    isPlaying.value = true;
  }

  void togglePlay() {
    if (player.playing) {
      player.pause();
      isPlaying.value = false;
    } else {
      player.play();
      isPlaying.value = true;
    }
  }

  void nextTrack() {
    currentIndex.value = (currentIndex.value + 1) % playlist.length;
    loadTrack();
  }

  void prevTrack() {
    currentIndex.value = (currentIndex.value - 1 + playlist.length) % playlist.length;
    loadTrack();
  }

  void selectTrack(int index) {
    currentIndex.value = index;
    loadTrack();
  }

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }
}
