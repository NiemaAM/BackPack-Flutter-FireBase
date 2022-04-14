import 'package:firstapp/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../jeux/Langues/Francais/animaux.dart';
import '../jeux/Langues/Francais/chiffres.dart';
import '../jeux/Langues/Francais/fruits.dart';
import '../jeux/Langues/Francais/legumes.dart';

// ignore: camel_case_types
class gridfr extends StatefulWidget {
  const gridfr({Key key}) : super(key: key);

  @override
  _gridfrState createState() => _gridfrState();
}

// ignore: camel_case_types
class _gridfrState extends State<gridfr> {
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
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const Fruits_Francais()));
          },
          // Image tapped
          child: Column(
            children: [
              Image.asset(
                'assets/img/fruits.png',
                height: 100,
                width: 100,
              ),
              Center(
                child: AppText(
                  text: 'Fruits',
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
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const Legumes_Francais()));
          },
          // Image tapped
          child: Column(
            children: [
              Image.asset(
                'assets/img/vegetables.png',
                height: 100,
                width: 100,
              ),
              Center(
                child: AppText(
                  text: 'Legumes',
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
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const Animaux_Francais()));
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
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const Chiffres_Francais()));
          },
          // Image tapped
          child: Column(
            children: [
              Image.asset(
                'assets/img/numbers.png',
                height: 100,
                width: 100,
              ),
              Center(
                child: AppText(
                  text: 'Chiffres',
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
