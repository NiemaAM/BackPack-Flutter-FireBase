import 'package:firstapp/widgets/app_text.dart';
import 'package:flutter/material.dart';

class ResponsiveButton extends StatelessWidget {
  bool isResponsive;
  double width;
  String text;
  ResponsiveButton({Key key, this.width, this.isResponsive, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(27),
          color: Colors.blue,
          // ignore: prefer_const_literals_to_create_immutables
          boxShadow: [
            // ignore: prefer_const_constructors
            BoxShadow(
              color: Colors.grey,
              offset: const Offset(
                0.0,
                0.0,
              ),
              blurRadius: 10.0,
              spreadRadius: 0.0,
            ),
            // ignore: prefer_const_constructors
            BoxShadow(
              color: Colors.white,
              offset: const Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: Align(
            alignment: Alignment.center,
            child: AppText(
              text: text,
              color: Colors.white,
              size: 35,
            )));
  }
}
