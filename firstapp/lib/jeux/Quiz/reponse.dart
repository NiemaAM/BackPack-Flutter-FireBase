import 'package:firstapp/widgets/app_text.dart';
import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answerText;
  final Color answerColor;
  final Function answerTap;

  // ignore: use_key_in_widget_constructors
  const Answer(
      {this.answerText, this.answerColor = Colors.blue, this.answerTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: answerTap,
      child: Container(
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 40.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: answerColor,
          borderRadius: BorderRadius.circular(40.0),
          // ignore: prefer_const_literals_to_create_immutables
          boxShadow: [
            const BoxShadow(
              color: Colors.blue,
              spreadRadius: 0,
              blurRadius: 0,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: AppText(
          text: answerText,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
