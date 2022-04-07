// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../pages/page_choix_jeux_langues.dart';

// ignore: camel_case_types
class menueInfos extends StatelessWidget {
  const menueInfos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const pageLanguesChoix()));
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      child: const Icon(
        Icons.arrow_drop_down,
        color: Colors.white,
        size: 80,
      ),
      color: Colors.transparent,
      splashColor: Colors.transparent,
      elevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
    );
  }
}
