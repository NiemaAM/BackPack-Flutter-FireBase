import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppMsg extends StatelessWidget {
  double size;
  final String text;
  final Color color;

  AppMsg({Key key, this.size = 40, this.text, this.color = Colors.black87})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        height: 0.8,
        color: color,
        fontSize: size,
      ),
    );
  }
}
