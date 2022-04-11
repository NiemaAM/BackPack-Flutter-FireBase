// ignore_for_file: deprecated_member_use

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../../widgets/app_text.dart';
import '../../../widgets/floating_retour.dart';
import '../itemModel.dart';

// ignore: camel_case_types
class Fruits_Anglais extends StatefulWidget {
  const Fruits_Anglais({Key key}) : super(key: key);

  @override
  _Fruits_AnglaisState createState() => _Fruits_AnglaisState();
}

// ignore: camel_case_types
class _Fruits_AnglaisState extends State<Fruits_Anglais> {
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
          value: 'apple', name: 'Apple', img: 'assets/img/fruits/apple.png'),
      ItemModel(
          value: 'apricot',
          name: 'Apricot',
          img: 'assets/img/fruits/apricot.png'),
      ItemModel(
          value: 'avocado',
          name: 'Avocado',
          img: 'assets/img/fruits/avocado.png'),
      ItemModel(
          value: 'banana', name: 'Banana', img: 'assets/img/fruits/banana.png'),
      ItemModel(
          value: 'blueberries',
          name: 'Blueberries',
          img: 'assets/img/fruits/blueberries.png'),
      ItemModel(
          value: 'melon', name: 'Melon', img: 'assets/img/fruits/melon.png'),
      ItemModel(
          value: 'cherries',
          name: 'Cherries',
          img: 'assets/img/fruits/cherries.png'),
      ItemModel(
          value: 'coconut',
          name: 'Coconut',
          img: 'assets/img/fruits/coconut.png'),
      ItemModel(
          value: 'dates', name: 'Dates', img: 'assets/img/fruits/dates.png'),
      ItemModel(value: 'fig', name: 'Fig', img: 'assets/img/fruits/fig.png'),
      ItemModel(
          value: 'grapes', name: 'Grapes', img: 'assets/img/fruits/grapes.png'),
      ItemModel(
          value: 'lemon', name: 'Lemon', img: 'assets/img/fruits/lemon.png'),
      ItemModel(
          value: 'mango', name: 'Mango', img: 'assets/img/fruits/mango.png'),
      ItemModel(
          value: 'orange', name: 'Orange', img: 'assets/img/fruits/orange.png'),
      ItemModel(
          value: 'papaya', name: 'papaya', img: 'assets/img/fruits/papaya.png'),
      ItemModel(
          value: 'peach', name: 'Peach', img: 'assets/img/fruits/peach.png'),
      ItemModel(value: 'pear', name: 'Pear', img: 'assets/img/fruits/pear.png'),
      ItemModel(
          value: 'pineapple',
          name: 'Pineapple',
          img: 'assets/img/fruits/pineapple.png'),
      ItemModel(
          value: 'pomegranate',
          name: 'Pomegranate',
          img: 'assets/img/fruits/pomegranate.png'),
      ItemModel(
          value: 'raspberry',
          name: 'Raspberry',
          img: 'assets/img/fruits/raspberry.png'),
      ItemModel(
          value: 'strawberry',
          name: 'Strawberry',
          img: 'assets/img/fruits/strawberry.png'),
      ItemModel(
          value: 'watermelon',
          name: 'Watermelon',
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
                        builder: (context) => const Fruits_Anglais()));
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
