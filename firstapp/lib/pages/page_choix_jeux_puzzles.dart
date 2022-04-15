import 'package:firstapp/widgets/app_text.dart';
import 'package:firstapp/widgets/grid_jeux_puzzles.dart';
import 'package:firstapp/widgets/menue_retour.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class pagePuzzleChoix extends StatefulWidget {
  const pagePuzzleChoix({Key key}) : super(key: key);

  @override
  _pagePuzzleChoixState createState() => _pagePuzzleChoixState();
}

// ignore: camel_case_types
class _pagePuzzleChoixState extends State<pagePuzzleChoix> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset("assets/img/haut.png"),
            Column(children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: const retour(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: height / 12,
              ),
              AppText(
                text: "Choisi le puzzle que tu veux !",
                size: width / 10,
                color: Colors.blue,
              ),
              SizedBox(
                width: width,
                height: height / 1.3,
                child: const gridpuzzle(),
              )
            ]),
          ],
        ),
      ),
    ));
  }
}
