import 'package:flutter/material.dart';

import '../pages/page_choix_jeux_langues.dart';

class menueInfos extends StatelessWidget {
  const menueInfos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => pageLanguesChoix()));
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      child: Icon(
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
