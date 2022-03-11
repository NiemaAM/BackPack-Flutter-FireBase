import 'package:flutter/material.dart';

class retour extends StatelessWidget {
  final Color color;
  const retour({Key key, this.color = Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.only(top: 15, left: 10),
      child: Row(
        children: [
          RaisedButton(
            onPressed: () {
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
