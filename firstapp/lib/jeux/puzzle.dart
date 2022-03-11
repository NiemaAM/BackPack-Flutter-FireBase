import 'package:firstapp/pages/page_acceuil.dart';
import 'package:firstapp/widgets/app_text.dart';
import 'package:firstapp/widgets/menue_retour.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

var now = new DateTime.now();
Random rnd = new Random(now.millisecondsSinceEpoch);

class Puzzle extends StatefulWidget {
  Puzzle({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _PuzzleState createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> {
  final winner = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0];
  final _white = Colors.white;
  final _green = Colors.blueAccent;
  List<int> scrambled = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0];
  int min = 0, max = 16;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/img/page_parametres.png"),
                  fit: BoxFit.cover)),
          child: Column(
            children: <Widget>[
              retour(),
              SizedBox(
                height: height / 10,
              ),
              AppText(
                text: "Puzzle de chiffres de 1 à 15 !",
                size: 40,
              ),
              Expanded(
                child: board(),
              ),
              SizedBox(
                height: height / 20,
              ),
              Container(
                height: height / 8,
                child: scrambleButton(),
              ),
            ],
          ),
        ));
  }

  Widget board() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
      width: width,
      child: GridView.count(
        crossAxisCount: 4,
        crossAxisSpacing: width / 100,
        mainAxisSpacing: width / 100,
        children: List.generate(scrambled.length, (index) {
          return gameTile(scrambled[index]);
        }),
      ),
    );
  }

  Widget gameTile(num) {
    bool isBlank = num == 0;
    return GestureDetector(
      onTap: () {
        moveTile(num);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isBlank ? _white : _green,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            "${isBlank ? ' ' : num}",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 32, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget scrambleButton() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height / 80,
      margin: EdgeInsets.only(bottom: height / 150),
      padding: EdgeInsets.all(15.0),
      child: ElevatedButton(
        onPressed: (() {
          scrambled.clear();
          scramble();
          setState(() {});
        }),
        child: AppText(
          text: 'Melanger',
          color: Colors.white,
          size: 25,
        ),
      ),
    );
  }

  void scramble() {
    int num = rnd.nextInt(max);
    if (scrambled.length == winner.length) {
      return;
    }

    if (scrambled.contains(num)) {
      scramble();
    } else {
      scrambled.add(num);
    }

    if (scrambled.length < winner.length) {
      scramble();
    }
  }

  void moveTile(tileClicked) {
    int blankTile = scrambled.indexOf(0);
    int selectedTile = scrambled.indexOf(tileClicked);
    if (tileClicked == 0) {
      return;
    }
    if (blankTile == 3 && selectedTile == 4) {
      return;
    } else if (blankTile == 7 && selectedTile == 8) {
      return;
    } else if (blankTile == 11 && selectedTile == 12) {
      return;
    } else if (blankTile == 4 && selectedTile == 3) {
      return;
    } else if (blankTile == 8 && selectedTile == 7) {
      return;
    } else if (blankTile == 12 && selectedTile == 11) {
      return;
    } else if (selectedTile - 4 == blankTile ||
        selectedTile + 4 == blankTile ||
        selectedTile - 1 == blankTile ||
        selectedTile + 1 == blankTile) {
      setState(() {
        scrambled[selectedTile] = 0;
        scrambled[blankTile] = tileClicked;
      });
      if (checkWin()) {
        _handleWin();
      }
    } else {
      return;
    }
  }

  bool checkWin() {
    bool win = true;
    for (var i = 0; i < winner.length; i++) {
      win = winner[i] == scrambled[i];
      if (!win) {
        break;
      }
    }
    return win;
  }

  void _handleWin() {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: AppText(
          text: "BIEN JOUER ",
          size: 25,
          color: Colors.blue,
        ),
        content: AppText(
          text: "Tu as resolue le puzzle !",
          size: 20,
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            child: AppText(
              text: 'Rejouer',
              size: 15,
              color: Colors.red,
            ),
            onPressed: () {
              Navigator.pop(context);
              scrambled.clear();
              scramble();
              setState(() {});
            },
          ),
          CupertinoDialogAction(
            child: AppText(
              text: 'Retour',
              size: 15,
              color: Colors.green,
            ),
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => acceil()));
            },
          )
        ],
      ),
    );
  }
}
