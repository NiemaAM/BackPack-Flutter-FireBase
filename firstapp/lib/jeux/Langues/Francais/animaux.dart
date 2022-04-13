// ignore_for_file: deprecated_member_use

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../../widgets/app_text.dart';
import '../../../widgets/floating_retour.dart';
import '../../../widgets/pop_up_jeux.dart';
import '../itemModel.dart';

// ignore: camel_case_types
class Animaux_Francais extends StatefulWidget {
  const Animaux_Francais({Key key}) : super(key: key);

  @override
  _Animaux_FrancaisState createState() => _Animaux_FrancaisState();
}

// ignore: camel_case_types
class _Animaux_FrancaisState extends State<Animaux_Francais> {
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
          value: 'un Castor',
          name: 'un Castor',
          img: 'assets/img/animaux/beaver.png'),
      ItemModel(
          value: 'un Oiseau',
          name: 'un Oiseau',
          img: 'assets/img/animaux/bird.png'),
      ItemModel(
          value: 'un Chameau',
          name: 'un Chameau',
          img: 'assets/img/animaux/camel.png'),
      ItemModel(
          value: 'un Chat', name: 'un Chat', img: 'assets/img/animaux/cat.png'),
      ItemModel(
          value: 'un Caméléon',
          name: 'un Caméléon',
          img: 'assets/img/animaux/chameleon.png'),
      ItemModel(
          value: 'un Poussin',
          name: 'un Poussin',
          img: 'assets/img/animaux/chick.png'),
      ItemModel(
          value: 'une Poule',
          name: 'une Poule',
          img: 'assets/img/animaux/chicken.png'),
      ItemModel(
          value: 'un Poisson',
          name: 'un Poisson',
          img: 'assets/img/animaux/clown-fish.png'),
      ItemModel(
          value: 'une Vache',
          name: 'une Vache',
          img: 'assets/img/animaux/cow.png'),
      ItemModel(
          value: 'un Crabe',
          name: 'un Crabe',
          img: 'assets/img/animaux/crab.png'),
      ItemModel(
          value: 'un Cerf',
          name: 'un Cerf',
          img: 'assets/img/animaux/deer.png'),
      ItemModel(
          value: 'un Chien',
          name: 'un Chien',
          img: 'assets/img/animaux/dog.png'),
      ItemModel(
          value: 'un Dauphin',
          name: 'un Dauphin',
          img: 'assets/img/animaux/dolphin.png'),
      ItemModel(
          value: 'un Canard',
          name: 'un Canard',
          img: 'assets/img/animaux/duck.png'),
      ItemModel(
          value: 'un Éléphant',
          name: 'un Éléphant',
          img: 'assets/img/animaux/elephant.png'),
      ItemModel(
          value: 'un Renard',
          name: 'un Renard',
          img: 'assets/img/animaux/fox.png'),
      ItemModel(
          value: 'une Girafe',
          name: 'une Girafe',
          img: 'assets/img/animaux/giraffe.png'),
      ItemModel(
          value: 'un Cochon d\'Inde',
          name: 'un Cochon d\'Inde',
          img: 'assets/img/animaux/guinea-pig.png'),
      ItemModel(
          value: 'un Hamster',
          name: 'un Hamster',
          img: 'assets/img/animaux/hamster.png'),
      ItemModel(
          value: 'un Cheval',
          name: 'un Cheval',
          img: 'assets/img/animaux/horse.png'),
      ItemModel(
          value: 'un Koala',
          name: 'un Koala',
          img: 'assets/img/animaux/koala.png'),
      ItemModel(
          value: 'un Lion',
          name: 'un Lion',
          img: 'assets/img/animaux/lion.png'),
      ItemModel(
          value: 'une Souris',
          name: 'une Souris',
          img: 'assets/img/animaux/mouse.png'),
      ItemModel(
          value: 'un Hibou',
          name: 'un Hibou',
          img: 'assets/img/animaux/owl.png'),
      ItemModel(
          value: 'un Panda',
          name: 'un Panda',
          img: 'assets/img/animaux/panda-bear.png'),
      ItemModel(
          value: 'un Perroquet',
          name: 'un Perroquet',
          img: 'assets/img/animaux/parrot.png'),
      ItemModel(
          value: 'un Manchot',
          name: 'un Manchot',
          img: 'assets/img/animaux/penguin.png'),
      ItemModel(
          value: 'un Coq',
          name: 'un Coq',
          img: 'assets/img/animaux/rooster.png'),
      ItemModel(
          value: 'un Requin',
          name: 'un Requin',
          img: 'assets/img/animaux/shark.png'),
      ItemModel(
          value: 'un Mouton',
          name: 'un Mouton',
          img: 'assets/img/animaux/sheep.png'),
      ItemModel(
          value: 'un Serpent',
          name: 'un Serpent',
          img: 'assets/img/animaux/snake.png'),
      ItemModel(
          value: 'un Écureuil',
          name: 'un Écureuil',
          img: 'assets/img/animaux/squirrel.png'),
      ItemModel(
          value: 'une Tortue',
          name: 'une Tortue',
          img: 'assets/img/animaux/turtle.png'),
      ItemModel(
          value: 'une Baleine',
          name: 'une Baleine',
          img: 'assets/img/animaux/whale.png'),
      ItemModel(
          value: 'un Loup',
          name: 'un Loup',
          img: 'assets/img/animaux/wolf.png'),
      ItemModel(
          value: 'un Zèbre',
          name: 'un Zèbre',
          img: 'assets/img/animaux/zebra.png'),
    ];
    items2 = List<ItemModel>.from(items);

    items.shuffle();
    items2.shuffle();
  }

  checkScore() {
    if (score == 36) {
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
                        text: '/36',
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
                                width: MediaQuery.of(context).size.width / 2.5,
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
