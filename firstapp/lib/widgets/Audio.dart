// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:audioplayers/audioplayers.dart';

// ignore: camel_case_types
class Audio {
  static AudioCache player = AudioCache(fixedPlayer: AudioPlayer());

  static void loop(String path) {
    player.loop(path);
  }

  static void play(String path) {
    player.play(path);
  }

  static void stop() {
    player.fixedPlayer.stop();
  }

  static void pause() {
    player.fixedPlayer.pause();
  }

  static void dispose() {
    player.fixedPlayer.dispose();
  }

  static void resume() {
    player.fixedPlayer.resume();
  }

  static void volume(double val) {
    player.fixedPlayer.setVolume(val);
  }
}
