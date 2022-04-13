// ignore_for_file: deprecated_member_use

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../../widgets/app_text.dart';
import '../../../widgets/floating_retour.dart';
import '../../../widgets/pop_up_jeux.dart';
import '../itemModel.dart';

// ignore: camel_case_types
class Chiffres_Francais extends StatefulWidget {
  const Chiffres_Francais({Key key}) : super(key: key);

  @override
  _Chiffres_FrancaisState createState() => _Chiffres_FrancaisState();
}

// ignore: camel_case_types
class _Chiffres_FrancaisState extends State<Chiffres_Francais> {
  var player = AudioCache();
  List<ItemModel> items;
  List<ItemModel> items2;
  int score;
  bool gameOver;

  initGame() {
    gameOver = false;
    score = 0;
    items = [
      ItemModel(value: 'Un', name: 'Un', img: 'assets/img/1.png'),
      ItemModel(value: 'Zero', name: 'Zero', img: 'assets/img/0.png'),
      ItemModel(value: 'Deux', name: 'Deux', img: 'assets/img/2.png'),
      ItemModel(value: 'Trois', name: 'Trois', img: 'assets/img/3.png'),
      ItemModel(value: 'Quatre', name: 'Quatre', img: 'assets/img/4.png'),
      ItemModel(value: 'Cinq', name: 'Cinq', img: 'assets/img/5.png'),
      ItemModel(value: 'Six', name: 'Six', img: 'assets/img/6.png'),
      ItemModel(value: 'Sept', name: 'Sept', img: 'assets/img/7.png'),
      ItemModel(value: 'Huit', name: 'Huit', img: 'assets/img/8.png'),
      ItemModel(value: 'Neuf', name: 'Neuf', img: 'assets/img/9.png'),
      ItemModel(value: 'Dix', name: 'Dix', img: 'assets/img/10.png'),
    ];
    items2 = List<ItemModel>.from(items);

    items.shuffle();
    items2.shuffle();
  }

  checkScore() {
    if (score == 11) {
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
  void initState() {
    super.initState();
    initGame();
  }

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) gameOver = true;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      // ignore: missing_required_param
      floatingActionButton: const FloatingActionButton(
        mini: false,
        shape: RoundedRectangleBorder(),
        child: retour(),
        backgroundColor: Colors.transparent,
        splashColor: Colors.transparent,
        elevation: 0,
        hoverElevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '$score',
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            .copyWith(color: Colors.blue),
                      ),
                      TextSpan(
                        text: '/11',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  const Spacer(),
                  Column(
                    children: items.map((item) {
                      return Container(
                        margin: const EdgeInsets.all(8),
                        child: Draggable<ItemModel>(
                          data: item,
                          childWhenDragging: Image(
                            image: AssetImage(item.img),
                            height: 80,
                          ),
                          feedback: Image(
                            image: AssetImage(item.img),
                            height: 90,
                          ),
                          child: Image(
                            image: AssetImage(item.img),
                            height: 60,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const Spacer(flex: 2),
                  Column(
                    children: items2.map((item) {
                      return DragTarget<ItemModel>(
                        onAccept: (receivedItem) {
                          if (item.value == receivedItem.value) {
                            setState(() {
                              items.remove(receivedItem);
                              items2.remove(item);
                            });
                            score += 1;
                            item.accepting = false;

                            player.play('sfx/ding.mp3');
                            checkScore();
                          } else {
                            setState(() {
                              item.accepting = false;
                              player.play('sfx/didum.mp3');
                            });
                          }
                        },
                        onWillAccept: (receivedItem) {
                          setState(() {
                            item.accepting = true;
                          });
                          return true;
                        },
                        onLeave: (receivedItem) {
                          setState(() {
                            item.accepting = false;
                          });
                        },
                        builder: (context, acceptedItems, rejectedItems) =>
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: item.accepting
                                      ? Colors.blue
                                      : Colors.grey[200],
                                ),
                                alignment: Alignment.center,
                                height: MediaQuery.of(context).size.width / 6.5,
                                width: MediaQuery.of(context).size.width / 3,
                                margin: const EdgeInsets.all(8),
                                child: AppText(
                                  text: item.name,
                                  size: 30,
                                  color: item.accepting
                                      ? Colors.white
                                      : Colors.black,
                                )),
                      );
                    }).toList(),
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
