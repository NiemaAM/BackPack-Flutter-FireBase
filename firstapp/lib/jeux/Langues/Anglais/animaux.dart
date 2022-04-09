// ignore_for_file: deprecated_member_use

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../../widgets/app_text.dart';
import '../../../widgets/floating_retour.dart';
import '../itemModel.dart';

// ignore: camel_case_types
class Animaux_Anglais extends StatefulWidget {
  const Animaux_Anglais({Key key}) : super(key: key);

  @override
  _Animaux_AnglaisState createState() => _Animaux_AnglaisState();
}

// ignore: camel_case_types
class _Animaux_AnglaisState extends State<Animaux_Anglais> {
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
          value: 'Beaver',
          name: 'Beaver',
          img: 'assets/img/animaux/beaver.png'),
      ItemModel(
          value: 'Bird', name: 'Bird', img: 'assets/img/animaux/bird.png'),
      ItemModel(
          value: 'Camel', name: 'Camel', img: 'assets/img/animaux/camel.png'),
      ItemModel(value: 'cat', name: 'Cat', img: 'assets/img/animaux/cat.png'),
      ItemModel(
          value: 'chameleon',
          name: 'Chameleon',
          img: 'assets/img/animaux/chameleon.png'),
      ItemModel(
          value: 'Chick', name: 'Chick', img: 'assets/img/animaux/chick.png'),
      ItemModel(
          value: 'chicken',
          name: 'chicken',
          img: 'assets/img/animaux/chicken.png'),
      ItemModel(
          value: 'Fish',
          name: 'Fish',
          img: 'assets/img/animaux/clown-fish.png'),
      ItemModel(value: 'Cow', name: 'Cow', img: 'assets/img/animaux/cow.png'),
      ItemModel(
          value: 'Crab', name: 'Crab', img: 'assets/img/animaux/crab.png'),
      ItemModel(
          value: 'deer', name: 'Deer', img: 'assets/img/animaux/deer.png'),
      ItemModel(value: 'dog', name: 'Dog', img: 'assets/img/animaux/dog.png'),
      ItemModel(
          value: 'dolphin',
          name: 'Dolphin',
          img: 'assets/img/animaux/dolphin.png'),
      ItemModel(
          value: 'duck', name: 'Duck', img: 'assets/img/animaux/duck.png'),
      ItemModel(
          value: 'elephant',
          name: 'Elephant',
          img: 'assets/img/animaux/elephant.png'),
      ItemModel(value: 'fox', name: 'Fox', img: 'assets/img/animaux/fox.png'),
      ItemModel(
          value: 'giraffe',
          name: 'Giraffe',
          img: 'assets/img/animaux/giraffe.png'),
      ItemModel(
          value: 'guinea pig',
          name: 'guinea pig',
          img: 'assets/img/animaux/guinea-pig.png'),
      ItemModel(
          value: 'hamster',
          name: 'Hamster',
          img: 'assets/img/animaux/hamster.png'),
      ItemModel(
          value: 'horse', name: 'Horse', img: 'assets/img/animaux/horse.png'),
      ItemModel(
          value: 'koala', name: 'Koala', img: 'assets/img/animaux/koala.png'),
      ItemModel(
          value: 'lion', name: 'Lion', img: 'assets/img/animaux/lion.png'),
      ItemModel(
          value: 'mouse', name: 'Mouse', img: 'assets/img/animaux/mouse.png'),
      ItemModel(value: 'owl', name: 'Owl', img: 'assets/img/animaux/owl.png'),
      ItemModel(
          value: 'panda',
          name: 'Panda',
          img: 'assets/img/animaux/panda-bear.png'),
      ItemModel(
          value: 'parrot',
          name: 'Parrot',
          img: 'assets/img/animaux/parrot.png'),
      ItemModel(
          value: 'penguin',
          name: 'Penguin',
          img: 'assets/img/animaux/penguin.png'),
      ItemModel(
          value: 'rooster',
          name: 'Rooster',
          img: 'assets/img/animaux/rooster.png'),
      ItemModel(
          value: 'shark', name: 'Shark', img: 'assets/img/animaux/shark.png'),
      ItemModel(
          value: 'sheep', name: 'Sheep', img: 'assets/img/animaux/sheep.png'),
      ItemModel(
          value: 'snake', name: 'Snake', img: 'assets/img/animaux/snake.png'),
      ItemModel(
          value: 'squirrel',
          name: 'Squirrel',
          img: 'assets/img/animaux/squirrel.png'),
      ItemModel(
          value: 'turtle',
          name: 'Turtle',
          img: 'assets/img/animaux/turtle.png'),
      ItemModel(
          value: 'whale', name: 'Whale', img: 'assets/img/animaux/whale.png'),
      ItemModel(
          value: 'wolf', name: 'Wolf', img: 'assets/img/animaux/wolf.png'),
      ItemModel(
          value: 'zebra', name: 'Zebra', img: 'assets/img/animaux/zebra.png'),
    ];
    items2 = List<ItemModel>.from(items);

    items.shuffle();
    items2.shuffle();
  }

  checkScore() {
    if (score == 36) {
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
                        builder: (context) => const Animaux_Anglais()));
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
