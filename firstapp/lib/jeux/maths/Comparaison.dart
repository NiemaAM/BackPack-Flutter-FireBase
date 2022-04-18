// ignore_for_file: deprecated_member_use, file_names

import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:firstapp/widgets/app_text.dart';
import 'package:flutter/material.dart';

import '../../widgets/menue_retour.dart';
import '../../widgets/pop_up_jeux.dart';

// ignore: camel_case_types
class Comparaison extends StatefulWidget {
  const Comparaison({Key key}) : super(key: key);

  @override
  _ComparaisonState createState() => _ComparaisonState();
}

// ignore: camel_case_types
class _ComparaisonState extends State<Comparaison> {
  var player = AudioCache();
  Color color = Colors.grey;
  int score = 0;
  String trueimg = "assets/img/vide.png";
  int num1 = 0;
  int num2 = 0;
  String image = "assets/img/vide.png";
  String img1 = "assets/img/greater-than-symbol.png";
  String img2 = "assets/img/equal.png";
  String img3 = "assets/img/less-than-symbol.png";
  bool item = false;
  bool first = true;
  checkFirst() {
    if (first == true) {
      setState(() {
        num1 = Random().nextInt(99);
        num2 = Random().nextInt(99);
        createimg();

        first = false;
      });
    }
  }

  createimg() {
    if (num1 == num2) {
      setState(() {
        trueimg = 'assets/img/equal.png';
      });
    }
    if (num1 < num2) {
      setState(() {
        trueimg = 'assets/img/less-than-symbol.png';
      });
    }
    if (num1 > num2) {
      setState(() {
        trueimg = 'assets/img/greater-than-symbol.png';
      });
    }
  }

  wait() async {
    await Future.delayed(const Duration(seconds: 1), () {});
    setState(() {
      image = "assets/img/vide.png";
      num1 = Random().nextInt(99);
      num2 = Random().nextInt(99);
      createimg();
    });
  }

  checkScore() {
    if (score == 10) {
      setState(() {
        score = 0;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const CustomDialogBox(
              text: "Retour",
              descriptions: "Ton score est maintenant :",
              title: "Bien jouer !",
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    checkFirst();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Stack(
        children: [
          Image.asset("assets/img/haut.png"),
          Center(
              child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: const retour(
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        // ignore: unnecessary_string_interpolations
                        text: '$score',
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            .copyWith(color: Colors.blue),
                      ),
                      TextSpan(
                        text: '/10',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height / 5,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width / 10,
                  ),
                  Container(
                    height: width / 4.5,
                    width: width / 4.5,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: AppText(
                      text: "$num1",
                      size: width / 6,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(child: Container()),
                  DragTarget<String>(
                    onAccept: (data) {
                      if (data == trueimg) {
                        setState(() {
                          image = trueimg;
                          player.play('sfx/ding.mp3');
                          score = score + 1;
                          checkScore();
                          wait();
                        });
                      } else {
                        player.play('sfx/didum.mp3');
                      }
                    },
                    builder: (context, _, __) => Container(
                      height: width / 4.5,
                      width: width / 4.5,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset(image),
                    ),
                  ),
                  Expanded(child: Container()),
                  Container(
                    height: width / 4.5,
                    width: width / 4.5,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: AppText(
                      text: "$num2",
                      size: width / 6,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: width / 10,
                  ),
                ],
              ),
              SizedBox(
                height: width / 7,
              ),
              Row(
                children: [
                  Expanded(child: Container()),
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: Draggable<String>(
                      data: img1,
                      childWhenDragging: Image(
                        image: AssetImage(img1),
                        height: width / 5,
                      ),
                      feedback: Image(
                        image: AssetImage(img1),
                        height: width / 4.5,
                      ),
                      child: Image(
                        image: AssetImage(img1),
                        height: width / 5,
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: Draggable<String>(
                      data: img2,
                      childWhenDragging: Image(
                        image: AssetImage(img2),
                        height: width / 5,
                      ),
                      feedback: Image(
                        image: AssetImage(img2),
                        height: width / 4.5,
                      ),
                      child: Image(
                        image: AssetImage(img2),
                        height: width / 5,
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: Draggable<String>(
                      data: img3,
                      childWhenDragging: Image(
                        image: AssetImage(img3),
                        height: width / 5,
                      ),
                      feedback: Image(
                        image: AssetImage(img3),
                        height: width / 4.5,
                      ),
                      child: Image(
                        image: AssetImage(img3),
                        height: width / 5,
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              ),
              SizedBox(
                height: height / 4,
              ),
            ],
          )),
        ],
      ),
    )));
  }
}
