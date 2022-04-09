// ignore_for_file: deprecated_member_use

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../../widgets/app_text.dart';
import '../../../widgets/floating_retour.dart';
import '../itemModel.dart';

// ignore: camel_case_types
class Legumes_Anglais extends StatefulWidget {
  const Legumes_Anglais({Key key}) : super(key: key);

  @override
  _Legumes_AnglaisState createState() => _Legumes_AnglaisState();
}

// ignore: camel_case_types
class _Legumes_AnglaisState extends State<Legumes_Anglais> {
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
          value: 'beet', name: 'beet', img: 'assets/img/legumes/beet.png'),
      ItemModel(
          value: 'broccoli',
          name: 'Broccoli',
          img: 'assets/img/legumes/broccoli.png'),
      ItemModel(
          value: 'cabbage',
          name: 'Cabbage',
          img: 'assets/img/legumes/cabbage.png'),
      ItemModel(
          value: 'carrot',
          name: 'Carrot',
          img: 'assets/img/legumes/carrot.png'),
      ItemModel(
          value: 'cauliflower',
          name: 'Cauliflower',
          img: 'assets/img/legumes/cauliflower.png'),
      ItemModel(
          value: 'cherry tomato',
          name: 'Cherry tomato',
          img: 'assets/img/legumes/cherry-tomato.png'),
      ItemModel(
          value: 'tomato',
          name: 'Tomato',
          img: 'assets/img/legumes/tomato.png'),
      ItemModel(
          value: 'chili', name: 'Chili', img: 'assets/img/legumes/chili.png'),
      ItemModel(
          value: 'corn', name: 'Corn', img: 'assets/img/legumes/corn.png'),
      ItemModel(
          value: 'cucumber',
          name: 'Cucumber',
          img: 'assets/img/legumes/cucumber.png'),
      ItemModel(
          value: 'eggplant',
          name: 'Eggplant',
          img: 'assets/img/legumes/eggplant.png'),
      ItemModel(
          value: 'green pea',
          name: 'Green pea',
          img: 'assets/img/legumes/green-pea.png'),
      ItemModel(
          value: 'leek', name: 'Leek', img: 'assets/img/legumes/leek.png'),
      ItemModel(
          value: 'lettuce',
          name: 'Lettuce',
          img: 'assets/img/legumes/lettuce.png'),
      ItemModel(
          value: 'onion', name: 'Onion', img: 'assets/img/legumes/onion.png'),
      ItemModel(
          value: 'pepper',
          name: 'Pepper',
          img: 'assets/img/legumes/pepper.png'),
      ItemModel(
          value: 'potato',
          name: 'Potato',
          img: 'assets/img/legumes/potato.png'),
      ItemModel(
          value: 'pumpkin',
          name: 'Pumpkin',
          img: 'assets/img/legumes/pumpkin.png'),
      ItemModel(
          value: 'red beans',
          name: 'red beans',
          img: 'assets/img/legumes/red-beans.png'),
      ItemModel(
          value: 'spinach',
          name: 'spinach',
          img: 'assets/img/legumes/spinach.png'),
      ItemModel(
          value: 'sweet potato',
          name: 'sweet potato',
          img: 'assets/img/legumes/sweet-potato.png'),
      ItemModel(
          value: 'zucchini',
          name: 'zucchini',
          img: 'assets/img/legumes/zucchini.png'),
    ];
    items2 = List<ItemModel>.from(items);

    items.shuffle();
    items2.shuffle();
  }

  checkScore() {
    if (score == 22) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          content: SizedBox(
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/img/confettis.png"),
                      fit: BoxFit.cover)),
              child: Center(
                  child: AppText(
                      text: "Bien jouer!", size: 40, color: Colors.black)),
            ),
          ),
          actions: <Widget>[
            Row(
              children: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    Navigator.of(ctx).pop();
                  },
                  child: AppText(
                    text: "Retour",
                    size: 30,
                    color: Colors.red,
                  ),
                ),
                Expanded(child: Container()),
                FlatButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    Navigator.of(ctx).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Legumes_Anglais()));
                  },
                  child: AppText(
                    text: "Rejouer",
                    size: 30,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
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
                        text: 'Score: ',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      TextSpan(
                        text: '$score',
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            .copyWith(color: Colors.blue),
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

                            player.play('musiques_fond/true.wav');
                            checkScore();
                          } else {
                            setState(() {
                              item.accepting = false;
                              player.play('musiques_fond/false.wav');
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