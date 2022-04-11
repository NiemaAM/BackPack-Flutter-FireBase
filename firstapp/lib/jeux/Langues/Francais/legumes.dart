// ignore_for_file: deprecated_member_use

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../../widgets/app_text.dart';
import '../../../widgets/floating_retour.dart';
import '../itemModel.dart';

// ignore: camel_case_types
class Legumes_Francais extends StatefulWidget {
  const Legumes_Francais({Key key}) : super(key: key);

  @override
  _Legumes_FrancaisState createState() => _Legumes_FrancaisState();
}

// ignore: camel_case_types
class _Legumes_FrancaisState extends State<Legumes_Francais> {
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
          value: 'une Betterave',
          name: 'une Betterave',
          img: 'assets/img/legumes/beet.png'),
      ItemModel(
          value: 'un Brocoli',
          name: 'un Brocoli',
          img: 'assets/img/legumes/broccoli.png'),
      ItemModel(
          value: 'un Chou',
          name: 'un Chou',
          img: 'assets/img/legumes/cabbage.png'),
      ItemModel(
          value: 'une Carotte',
          name: 'une Carotte',
          img: 'assets/img/legumes/carrot.png'),
      ItemModel(
          value: 'un Chou-fleur',
          name: 'un Chou-fleur',
          img: 'assets/img/legumes/cauliflower.png'),
      ItemModel(
          value: 'une Tomate cerise',
          name: 'une Tomate cerise',
          img: 'assets/img/legumes/cherry-tomato.png'),
      ItemModel(
          value: 'une Tomate',
          name: 'une Tomate',
          img: 'assets/img/legumes/tomato.png'),
      ItemModel(
          value: 'un Piment',
          name: 'un Piment',
          img: 'assets/img/legumes/chili.png'),
      ItemModel(
          value: 'un Maïs',
          name: 'un Maïs',
          img: 'assets/img/legumes/corn.png'),
      ItemModel(
          value: 'un Concombre',
          name: 'un Concombre',
          img: 'assets/img/legumes/cucumber.png'),
      ItemModel(
          value: 'une Aubergine',
          name: 'une Aubergine',
          img: 'assets/img/legumes/eggplant.png'),
      ItemModel(
          value: 'un Petit pois',
          name: 'un Petit pois',
          img: 'assets/img/legumes/green-pea.png'),
      ItemModel(
          value: 'un Poireau',
          name: 'un Poireau',
          img: 'assets/img/legumes/leek.png'),
      ItemModel(
          value: 'une Laitue',
          name: 'une Laitue',
          img: 'assets/img/legumes/lettuce.png'),
      ItemModel(
          value: 'un Oignon',
          name: 'un Oignon',
          img: 'assets/img/legumes/onion.png'),
      ItemModel(
          value: 'un Poivron',
          name: 'un Poivron',
          img: 'assets/img/legumes/pepper.png'),
      ItemModel(
          value: 'une Pomme de terre',
          name: 'une Pomme de terre',
          img: 'assets/img/legumes/potato.png'),
      ItemModel(
          value: 'une Citrouille',
          name: 'une Citrouille',
          img: 'assets/img/legumes/pumpkin.png'),
      ItemModel(
          value: 'un Haricot rouge',
          name: 'un Haricot rouge',
          img: 'assets/img/legumes/red-beans.png'),
      ItemModel(
          value: 'un Épinard',
          name: 'un Épinard',
          img: 'assets/img/legumes/spinach.png'),
      ItemModel(
          value: 'une Patate douce',
          name: 'une Patate douce',
          img: 'assets/img/legumes/sweet-potato.png'),
      ItemModel(
          value: 'une Courgette',
          name: 'une Courgette',
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
                        builder: (context) => const Legumes_Francais()));
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
                                width: MediaQuery.of(context).size.width / 2,
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
