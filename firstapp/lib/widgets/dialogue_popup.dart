import 'package:flutter/material.dart';

import 'app_text.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const Button(
    AppText appText, {
    this.text,
    this.onClicked,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => RaisedButton(
        child: AppText(
          text: text,
        ),
        color: Colors.transparent,
        splashColor: Colors.transparent,
        elevation: 0,
        hoverElevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
        onPressed: () {},
      );
}
