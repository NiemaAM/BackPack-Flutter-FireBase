// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'Audio.dart';

// ignore: camel_case_types
class retour extends StatelessWidget {
  final Color color;
  const retour({Key key, this.color = Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var player = AudioCache();
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.only(top: 15, left: 10),
      child: Row(
        children: [
          RaisedButton(
            onPressed: () {
              player.play('sfx/pop.mp3');
              Audio.pause();
              Navigator.of(context).pop();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(Icons.arrow_back, size: width / 8, color: color),
            color: Colors.transparent,
            splashColor: Colors.transparent,
            elevation: 0,
            hoverElevation: 0,
            focusElevation: 0,
            highlightElevation: 0,
          )
        ],
      ),
    );
  }
}
