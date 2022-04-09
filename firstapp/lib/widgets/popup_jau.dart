// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'app_text.dart';

// ignore: camel_case_types
class popup extends StatelessWidget {
  final Color color;
  const popup({Key key, this.color = Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            content: SizedBox(
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/img/confettis.png"),
                        fit: BoxFit.cover)),
                child: Center(
                    child: AppText(
                        text: "Bien jouer!", size: 40, color: Colors.black)),
              ),
            ),
            actions: <Widget>[
              Row(
                children: [
                  FlatButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: AppText(
                      text: "Retour",
                      size: 30,
                      color: Colors.red,
                    ),
                  ),
                  Expanded(child: Container()),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: AppText(
                      text: "Rejouer",
                      size: 30,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
