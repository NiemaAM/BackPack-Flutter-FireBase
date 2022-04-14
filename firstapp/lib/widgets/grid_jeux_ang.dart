import 'package:firstapp/jeux/Langues/Anglais/animaux.dart';
import 'package:firstapp/jeux/Langues/Anglais/chiffres.dart';
import 'package:firstapp/jeux/Langues/Anglais/fruits.dart';
import 'package:firstapp/jeux/Langues/Anglais/legumes.dart';
import 'package:firstapp/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

// ignore: camel_case_types
class gridang extends StatefulWidget {
  const gridang({Key key}) : super(key: key);

  @override
  _gridangState createState() => _gridangState();
}

// ignore: camel_case_types
class _gridangState extends State<gridang> {
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
                builder: (context) => const Fruits_Anglais()));
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
                builder: (context) => const Legumes_Anglais()));
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
                  text: 'Vegetables',
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
                builder: (context) => const Animaux_Anglais()));
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
                  text: 'Animals',
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
                builder: (context) => const Chiffres_Anglais()));
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
                  text: 'Numbers',
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
