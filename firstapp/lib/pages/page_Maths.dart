// ignore_for_file: deprecated_member_use, file_names
import 'package:firstapp/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../widgets/grid_jeux_maths.dart';
import '../widgets/menue_retour.dart';

// ignore: camel_case_types
class Maths extends StatefulWidget {
  const Maths({Key key}) : super(key: key);

  @override
  _MathsState createState() => _MathsState();
}

// ignore: camel_case_types
class _MathsState extends State<Maths> {
  var player = AudioCache();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  height: height / 10,
                ),
                AppText(
                  text: "Choisi ce que tu veux apprendre !",
                  size: width / 10,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: width,
                  height: height / 1.3,
                  child: const gridMaths(),
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
