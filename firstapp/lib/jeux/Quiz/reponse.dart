import 'package:firstapp/widgets/app_text.dart';
import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answerText;
  final Color answerColor;
  final Function answerTap;

  Answer({this.answerText, this.answerColor, this.answerTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: answerTap,
      child: Container(
        padding: EdgeInsets.all(15.0),
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: answerColor,
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: AppText(
          text: answerText,
          size: 25,
        ),
      ),
    );
  }
}
