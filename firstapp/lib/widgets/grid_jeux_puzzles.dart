// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firstapp/jeux/puzzle_images/puzzle_image_1.dart';
import 'package:firstapp/jeux/puzzle_images/puzzle_image_2.dart';
import 'package:firstapp/jeux/puzzle_images/puzzle_image_3.dart';
import 'package:firstapp/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pop_up_puzzel.dart';

// ignore: camel_case_types
class gridpuzzle extends StatefulWidget {
  const gridpuzzle({Key key}) : super(key: key);

  @override
  _gridpuzzleState createState() => _gridpuzzleState();
}

// ignore: camel_case_types
class _gridpuzzleState extends State<gridpuzzle> {
  String avatar = './assets/img/blank.png';
  String score = ' ';
  int score_int = 0;
  int new_score = 0;
  String deviceName = '';
  String deviceVersion = '';
  String identifier = '';
  List links = [
    const SlidePuzzle_1(),
    const SlidePuzzle_2(),
    const SlidePuzzle_3(),
  ];
  Future<void> _deviceDetails() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        setState(() {
          deviceName = build.model;
          deviceVersion = build.version.toString();
          identifier = build.androidId;
        });
        //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        setState(() {
          deviceName = data.name;
          deviceVersion = data.systemVersion;
          identifier = data.identifierForVendor;
        }); //UUID for iOS
      }
    } on PlatformException {
      // ignore: avoid_print
      print('Failed to get platform version');
    }
  }

  getData() async {
    _deviceDetails();
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('$identifier/id').get();
    final snapshot2 = await ref.child('$identifier/Enfant/Avatar').get();
    final snapshot3 = await ref.child('$identifier/Enfant/Score').get();
    if (snapshot.value == identifier) {
      setState(() {
        avatar = snapshot2.value;
        score = snapshot3.value;
        score_int = int.parse(score);
      });
    }
  }

  changeScore(int pieces) async {
    await Future.delayed(const Duration(microseconds: 1), () {
      setState(() {
        if (score_int - pieces >= 0) {
          new_score = score_int - pieces;
        }
      });
      final ref = FirebaseDatabase.instance.ref();
      ref.update({
        "$identifier/Enfant/Score": "$new_score",
      });
    });
  }

  checkScore(int i, int pieces) {
    getData();
    if (score_int >= pieces) {
      changeScore(pieces);
      return Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => links[i]));
    } else {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return const CustomDialogBox(
              text: "Fermer",
              descriptions: "Ton score est :",
              title: "Tu n'as pas assez de pieces pour jouer.",
            );
          });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    double width = MediaQuery.of(context).size.width;
    return GridView.count(
      padding: const EdgeInsets.all(20),
      crossAxisCount: 2,
      mainAxisSpacing: width / 30,
      crossAxisSpacing: width / 30,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            checkScore(0, 50);
          },
          // Image tapped
          child: Column(
            children: [
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      image: AssetImage("./assets/img/avatar_1.png"),
                      fit: BoxFit.cover),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/img/star.png",
                      height: width / 13,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    AppText(
                      text: '50',
                      size: width / 10,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            checkScore(1, 100);
          },
          // Image tapped
          child: Column(
            children: [
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      image: AssetImage("./assets/img/avatar_2.png"),
                      fit: BoxFit.cover),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/img/star.png",
                      height: width / 13,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    AppText(
                      text: '100',
                      size: width / 10,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            checkScore(2, 20);
          },
          child: Column(
            children: [
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      image: AssetImage("./assets/img/avatar_3.png"),
                      fit: BoxFit.cover),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/img/star.png",
                      height: width / 13,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    AppText(
                      text: '20',
                      size: width / 10,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
