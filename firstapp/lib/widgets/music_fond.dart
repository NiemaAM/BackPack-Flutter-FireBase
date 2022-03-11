import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

class MusicFond extends StatelessWidget {
  String action;
  String music;
  MusicFond({Key key, this.action = "", this.music = ""}) : super(key: key);
  AudioCache player = new AudioCache(fixedPlayer: AudioPlayer());
  _play(String nom) {
    player.play(nom);
  }

  _loop(String nom) {
    player.play(nom);
  }

  _stop() {
    player.fixedPlayer.stop();
  }

  _pause() {
    player.fixedPlayer.pause();
  }

  _resume() {
    player.fixedPlayer.resume();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 0.1,
        width: 0.1,
        child: Column(
          children: [
            if (action == "play") ..._play(music),
            if (action == "stop") ..._stop(),
            if (action == "loop") ..._loop(music),
            if (action == "pause") ..._pause(),
            if (action == "resume") ..._resume(),
          ],
        ));
  }
}
