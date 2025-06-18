import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/speaker_controller.dart';

class SpeakerPage extends StatelessWidget {
  final speakerC = Get.put(SpeakerController());

  @override
  Widget build(BuildContext context) {
    speakerC.loadTrack();

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Pemutar Audio", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Obx(() {
        final current = speakerC.playlist[speakerC.currentIndex.value];

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNowPlayingCard(current['title'] ?? '', speakerC),
                SizedBox(height: 30),
                Text(
                  "Playlist",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10),
                ...List.generate(speakerC.playlist.length, (index) {
                  final song = speakerC.playlist[index];
                  final isSelected = index == speakerC.currentIndex.value;

                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: isSelected ? 4 : 1,
                    color: isSelected ? Colors.blue[100] : Colors.white,
                    child: ListTile(
                      title: Text(song['title'] ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.blueAccent : Colors.black)),
                      onTap: () {
                        speakerC.selectTrack(index);
                      },
                      leading: Icon(Icons.music_note,
                          color: isSelected ? Colors.blueAccent : Colors.grey),
                    ),
                  );
                }),
                SizedBox(height: 80),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildNowPlayingCard(String title, SpeakerController speakerC) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueAccent, Colors.lightBlueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))
        ],
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Sedang Diputar",
              style: TextStyle(color: Colors.white70, fontSize: 14)),
          SizedBox(height: 5),
          Text(title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 15),
          StreamBuilder<Duration>(
            stream: speakerC.player.positionStream,
            builder: (context, snapshot) {
              final pos = snapshot.data ?? Duration.zero;
              final dur = speakerC.player.duration ?? Duration(seconds: 1);
              return Column(
                children: [
                  Slider(
                    activeColor: Colors.white,
                    inactiveColor: Colors.white38,
                    min: 0,
                    max: dur.inMilliseconds.toDouble(),
                    value: pos.inMilliseconds.clamp(0, dur.inMilliseconds).toDouble(),
                    onChanged: (value) {
                      speakerC.player.seek(Duration(milliseconds: value.toInt()));
                    },
                  ),
                  Text(
                    "${_format(pos)} / ${_format(dur)}",
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: speakerC.prevTrack,
                icon: Icon(Icons.skip_previous, color: Colors.white),
              ),
              IconButton(
                onPressed: speakerC.togglePlay,
                icon: Icon(
                  speakerC.isPlaying.value ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: speakerC.nextTrack,
                icon: Icon(Icons.skip_next, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _format(Duration d) {
    final minutes = d.inMinutes.toString().padLeft(2, '0');
    final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }
}
