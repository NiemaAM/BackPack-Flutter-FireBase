import 'package:firstapp/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../jeux/maths/Comparaison.dart';

// ignore: camel_case_types
class gridMaths extends StatefulWidget {
  const gridMaths({Key key}) : super(key: key);

  @override
  _gridMathsState createState() => _gridMathsState();
}

// ignore: camel_case_types
class _gridMathsState extends State<gridMaths> {
  var player = AudioCache();
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
                MaterialPageRoute(builder: (context) => const Comparaison()));
          },
          // Image tapped
          child: Column(
            children: [
              Image.asset(
                'assets/img/signes.png',
                height: 100,
                width: 100,
              ),
              Center(
                child: AppText(
                  text: 'Comparaison',
                  size: width / 10,
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
                MaterialPageRoute(builder: (context) => const Comparaison()));
          },
          // Image tapped
          child: Column(
            children: [
              Image.asset(
                'assets/img/addition.png',
                height: 100,
                width: 100,
              ),
              Center(
                child: AppText(
                  text: 'Addition',
                  size: width / 10,
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
                MaterialPageRoute(builder: (context) => const Comparaison()));
          },
          // Image tapped
          child: Column(
            children: [
              Image.asset(
                'assets/img/substraction.png',
                height: 100,
                width: 100,
              ),
              Center(
                child: AppText(
                  text: 'Soustration',
                  size: width / 10,
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
                MaterialPageRoute(builder: (context) => const Comparaison()));
          },
          // Image tapped
          child: Column(
            children: [
              Image.asset(
                'assets/img/multiplication.png',
                height: 100,
                width: 100,
              ),
              Center(
                child: AppText(
                  text: 'Multiplication',
                  size: width / 10,
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
