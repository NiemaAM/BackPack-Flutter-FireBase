import 'package:firstapp/jeux/Quiz/quiz.dart';
import 'package:firstapp/jeux/Quiz/quiz_addition.dart';
import 'package:firstapp/widgets/app_text.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class gridquiz extends StatefulWidget {
  const gridquiz({Key key}) : super(key: key);

  @override
  _gridquizState createState() => _gridquizState();
}

// ignore: camel_case_types
class _gridquizState extends State<gridquiz> {
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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const QuizAddition()));
            },
            // Image tapped
            child: Container(
              padding: const EdgeInsets.all(10),
              width: width / 30,
              height: width / 30,
              color: Colors.blue,
              child: AppText(
                text: "Quiz Addition",
                color: Colors.white,
              ),
            )),
        GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const Quiz()));
            },
            // Image tapped
            child: Container(
              padding: const EdgeInsets.all(10),
              width: width / 30,
              height: width / 30,
              color: Colors.blue,
              child: AppText(
                text: "Quiz 2",
                color: Colors.white,
              ),
            )),
        GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const Quiz()));
            },
            // Image tapped
            child: Container(
              padding: const EdgeInsets.all(10),
              width: width / 30,
              height: width / 30,
              color: Colors.blue,
              child: AppText(
                text: "Quiz 3",
                color: Colors.white,
              ),
            )),
      ],
    );
  }
}
