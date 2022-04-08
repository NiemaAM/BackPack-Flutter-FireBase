// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:audioplayers/audioplayers.dart';

// ignore: camel_case_types
class Audio_BK {
  static AudioCache playerBK = AudioCache(fixedPlayer: AudioPlayer());

  static void loopBK(String path) {
    playerBK.loop(path);
  }

  static void playBK(String path) {
    playerBK.play(path);
  }

  static void stopBK() {
    playerBK.fixedPlayer.stop();
  }

  static void pauseBK() {
    playerBK.fixedPlayer.pause();
  }

  static void disposeBK() {
    playerBK.fixedPlayer.dispose();
  }

  static void resumeBK() {
    playerBK.fixedPlayer.resume();
  }

  static void volumeBK(double val) {
    playerBK.fixedPlayer.setVolume(val);
  }
}
