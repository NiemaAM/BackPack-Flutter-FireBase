// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../pages/verifier_mot_de_passe.dart';

// ignore: camel_case_types
class menue extends StatelessWidget {
  const menue({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 10),
      child: Row(
        children: [
          RaisedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const verifier_mot_de_passe()));
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(Icons.menu, size: width / 8, color: Colors.white),
            color: Colors.transparent,
            splashColor: Colors.transparent,
            elevation: 0,
            hoverElevation: 0,
            focusElevation: 0,
            highlightElevation: 0,
          ),
          Expanded(child: Container()),
          Container(
            margin: const EdgeInsets.only(right: 20),
            width: width / 5,
            height: width / 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
