// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:audioplayers/audioplayers.dart';

// ignore: camel_case_types
class Audio_BK {
  static AudioCache playerBK = AudioCache(fixedPlayer: AudioPlayer());
  static AudioCache playerBK_2 = AudioCache(fixedPlayer: AudioPlayer());

  static void loopBK() {
    if (playerBK_2 == null) {
      playerBK.loop("musiques_fond/HeatleyBros_main.mp3");
      Audio_BK.volumeBK(1.0);
    } else {
      pauseBK_2();
      playerBK.loop("musiques_fond/HeatleyBros_main.mp3");
      Audio_BK.volumeBK(1.0);
    }
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

///////////////////////////////////////////////////////////////////
  static void loopBK_2() {
    if (playerBK == null) {
      playerBK_2.loop("musiques_fond/music2_fiver_milo.mp3");
      Audio_BK.volumeBK_2(1.0);
    } else {
      pauseBK();
      playerBK_2.loop("musiques_fond/music2_fiver_milo.mp3");
      Audio_BK.volumeBK_2(1.0);
    }
  }

  static void playBK_2(String path) {
    playerBK_2.play(path);
  }

  static void stopBK_2() {
    playerBK_2.fixedPlayer.stop();
  }

  static void pauseBK_2() {
    playerBK_2.fixedPlayer.pause();
  }

  static void disposeBK_2() {
    playerBK_2.fixedPlayer.dispose();
  }

  static void resumeBK_2() {
    playerBK_2.fixedPlayer.resume();
  }

  static void volumeBK_2(double val) {
    playerBK_2.fixedPlayer.setVolume(val);
  }
}
