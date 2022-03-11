import 'package:firstapp/jeux/puzzle.dart';
import 'package:firstapp/jeux/puzzle_images/puzzle_image_1.dart';
import 'package:firstapp/jeux/puzzle_images/puzzle_image_2.dart';
import 'package:firstapp/jeux/puzzle_images/puzzle_image_3.dart';
import 'package:firstapp/jeux/puzzle_images/puzzle_image_4.dart';
import 'package:firstapp/jeux/puzzle_images/puzzle_image_5.dart';
import 'package:firstapp/jeux/puzzle_images/puzzle_image_6.dart';
import 'package:flutter/material.dart';

class gridpuzzle extends StatefulWidget {
  const gridpuzzle({Key key}) : super(key: key);

  @override
  _gridpuzzleState createState() => _gridpuzzleState();
}

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
    double height = MediaQuery.of(context).size.height;
    return GridView.count(
      padding: const EdgeInsets.all(20),
      crossAxisCount: 2,
      mainAxisSpacing: width / 30,
      crossAxisSpacing: width / 30,
      children: <Widget>[
        GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SlidePuzzle_1()));
            },
            // Image tapped
            child: Image.asset(imgs[0])),
        GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SlidePuzzle_2()));
            },
            // Image tapped
            child: Image.asset(imgs[1])),
        GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SlidePuzzle_3()));
            },
            // Image tapped
            child: Image.asset(imgs[2])),
        GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SlidePuzzle_4()));
            },
            // Image tapped
            child: Image.asset(imgs[3])),
        GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SlidePuzzle_5()));
            },
            // Image tapped
            child: Image.asset(imgs[4])),
        GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SlidePuzzle_6()));
            },
            // Image tapped
            child: Image.asset(imgs[5])),
        GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Puzzle()));
            },
            // Image tapped
            child: Image.asset(imgs[6])),
      ],
    );
  }
}
