// ignore_for_file: deprecated_member_use

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../../widgets/app_text.dart';
import '../../../widgets/floating_retour.dart';
import '../../../widgets/pop_up_jeux.dart';
import '../itemModel.dart';

// ignore: camel_case_types
class Fruits_Francais extends StatefulWidget {
  const Fruits_Francais({Key key}) : super(key: key);

  @override
  _Fruits_FrancaisState createState() => _Fruits_FrancaisState();
}

// ignore: camel_case_types
class _Fruits_FrancaisState extends State<Fruits_Francais> {
  var player = AudioCache();
  List<ItemModel> items;
  List<ItemModel> items2;
  int score;
  bool gameOver;

  initGame() {
    gameOver = false;
    score = 0;
    items = [
      ItemModel(
          value: 'une Pomme',
          name: 'une Pomme',
          img: 'assets/img/fruits/apple.png'),
      ItemModel(
          value: 'un Abricot',
          name: 'un Abricot',
          img: 'assets/img/fruits/apricot.png'),
      ItemModel(
          value: 'un Avocat',
          name: 'un Avocat',
          img: 'assets/img/fruits/avocado.png'),
      ItemModel(
          value: 'une Banane',
          name: 'une Banane',
          img: 'assets/img/fruits/banana.png'),
      ItemModel(
          value: 'une Myrtilles',
          name: 'une Myrtilles',
          img: 'assets/img/fruits/blueberries.png'),
      ItemModel(
          value: 'un Melon',
          name: 'un Melon',
          img: 'assets/img/fruits/melon.png'),
      ItemModel(
          value: 'une Cerise',
          name: 'une Cerise',
          img: 'assets/img/fruits/cherries.png'),
      ItemModel(
          value: 'une Noix de coco',
          name: 'une Noix de coco',
          img: 'assets/img/fruits/coconut.png'),
      ItemModel(
          value: 'une Datte',
          name: 'une Datte',
          img: 'assets/img/fruits/dates.png'),
      ItemModel(
          value: 'une Figue',
          name: 'une Figue',
          img: 'assets/img/fruits/fig.png'),
      ItemModel(
          value: 'un Raisin',
          name: 'un Raisin',
          img: 'assets/img/fruits/grapes.png'),
      ItemModel(
          value: 'un Citron',
          name: 'un Citron',
          img: 'assets/img/fruits/lemon.png'),
      ItemModel(
          value: 'une Mangue',
          name: 'une Mangue',
          img: 'assets/img/fruits/mango.png'),
      ItemModel(
          value: 'une Orange',
          name: 'une Orange',
          img: 'assets/img/fruits/orange.png'),
      ItemModel(
          value: 'una Papaye',
          name: 'una Papaye',
          img: 'assets/img/fruits/papaya.png'),
      ItemModel(
          value: 'une Pêche',
          name: 'une Pêche',
          img: 'assets/img/fruits/peach.png'),
      ItemModel(
          value: 'une Poire',
          name: 'une Poire',
          img: 'assets/img/fruits/pear.png'),
      ItemModel(
          value: 'un Ananas',
          name: 'un Ananas',
          img: 'assets/img/fruits/pineapple.png'),
      ItemModel(
          value: 'une Grenade',
          name: 'une Grenade',
          img: 'assets/img/fruits/pomegranate.png'),
      ItemModel(
          value: 'une Framboise',
          name: 'une Framboise',
          img: 'assets/img/fruits/raspberry.png'),
      ItemModel(
          value: 'une Fraise',
          name: 'une Fraise',
          img: 'assets/img/fruits/strawberry.png'),
      ItemModel(
          value: 'une Pastèque',
          name: 'une Pastèque',
          img: 'assets/img/fruits/watermelon.png'),
    ];
    items2 = List<ItemModel>.from(items);

    items.shuffle();
    items2.shuffle();
  }

  checkScore() {
    if (score == 22) {
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
    double width = MediaQuery.of(context).size.width;
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
                        text: '/22',
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
                            height: width / 5,
                          ),
                          feedback: Image(
                            image: AssetImage(item.img),
                            height: width / 4,
                          ),
                          child: Image(
                            image: AssetImage(item.img),
                            height: width / 6,
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
                                height: width / 6.5,
                                width: width / 2.5,
                                margin: const EdgeInsets.all(8),
                                child: AppText(
                                  text: item.name,
                                  size: width / 13,
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
