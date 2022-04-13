// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

import 'app_text.dart';

class pushButton extends StatefulWidget {
  final String text;
  final Widget widget;
  const pushButton({Key key, this.text, this.widget}) : super(key: key);

  @override
  State<pushButton> createState() => _pushButtonState();
}

class _pushButtonState extends State<pushButton> {
  static const double _shadowHeight = 4;
  double _position = 4;
  @override
  Widget build(BuildContext context) {
    const double _height = 64 - _shadowHeight;
    return GestureDetector(
      onTapUp: (_) {
        widget.widget;
      },
      onTapDown: (_) {
        setState(() {
          _position = 0;
        });
      },
      onTapCancel: () {
        setState(() {
          _position = 6;
        });
      },
      child: SizedBox(
        height: _height + _shadowHeight + 10,
        width: 200,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                height: _height,
                width: 200,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 21, 97, 158),
                  // ignore: unnecessary_const
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              curve: Curves.easeIn,
              bottom: _position,
              duration: const Duration(milliseconds: 70),
              child: Container(
                height: _height,
                width: 200,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: Center(
                  child: AppText(
                    text: widget.text,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
