import 'package:firstapp/jeux/puzzle_images/puzzle_image_1.dart';
import 'package:firstapp/jeux/puzzle_images/puzzle_image_2.dart';
import 'package:firstapp/jeux/puzzle_images/puzzle_image_3.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class gridpuzzle extends StatefulWidget {
  const gridpuzzle({Key key}) : super(key: key);

  @override
  _gridpuzzleState createState() => _gridpuzzleState();
}

// ignore: camel_case_types
class _gridpuzzleState extends State<gridpuzzle> {
  List imgs = [
    "./assets/img/avatar_1.png",
    "./assets/img/avatar_2.png",
    "./assets/img/avatar_3.png",
    "./assets/img/avatar_4.png",
    "./assets/img/avatar_5.png",
    "./assets/img/avatar_6.png",
    "./assets/img/math.png"
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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SlidePuzzle_1()));
            },
            // Image tapped
            child: Image.asset(imgs[0])),
        GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SlidePuzzle_2()));
            },
            // Image tapped
            child: Image.asset(imgs[1])),
        GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SlidePuzzle_3()));
            },
            child: Image.asset(imgs[2])),
      ],
    );
  }
}
