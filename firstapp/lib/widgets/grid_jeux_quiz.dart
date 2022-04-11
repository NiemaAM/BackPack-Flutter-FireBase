import 'package:firstapp/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../jeux/Quiz/quiz_annimaux.dart';
import '../jeux/Quiz/quiz_maths.dart';

// ignore: camel_case_types
class gridquiz extends StatefulWidget {
  const gridquiz({Key key}) : super(key: key);

  @override
  _gridquizState createState() => _gridquizState();
}

// ignore: camel_case_types
class _gridquizState extends State<gridquiz> {
  var player = AudioCache();
  List imgs = [
    "./assets/img/Quiz.png",
    "./assets/img/Quiz.png",
    "./assets/img/Quiz.png",
    "./assets/img/Quiz.png",
    "./assets/img/Quiz.png",
    "./assets/img/Quiz.png",
    "./assets/img/Quiz.png"
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GridView.count(
      padding: const EdgeInsets.all(20),
      crossAxisCount: 2,
      mainAxisSpacing: width / 30,
      crossAxisSpacing: width / 30,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            player.play('sfx/poop.mp3');
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const Quiz_Annimaux()));
          },
          // Image tapped
          child: Column(
            children: [
              Image.asset(
                'assets/img/livestock.png',
                height: 100,
                width: 100,
              ),
              Center(
                child: AppText(
                  text: 'Animaux',
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            player.play('sfx/poop.mp3');
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const Quiz_Maths()));
          },
          // Image tapped
          child: Column(
            children: [
              Image.asset(
                'assets/img/blackboard.png',
                height: 100,
                width: 100,
              ),
              Center(
                child: AppText(
                  text: 'Maths',
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            player.play('sfx/poop.mp3');
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const Quiz_Maths()));
          },
          // Image tapped
          child: Column(
            children: [
              Image.asset(
                'assets/img/fruits_.png',
                height: 100,
                width: 100,
              ),
              Center(
                child: AppText(
                  text: 'Fruits',
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
