// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firstapp/pages/page_acceuil.dart';
import 'package:firstapp/widgets/app_text.dart';
import 'package:firstapp/widgets/menue_retour.dart';
import 'package:flutter/material.dart';
import 'package:remove_emoji/remove_emoji.dart';
import 'package:flutter/services.dart';

import '../widgets/grid_avatar_choix.dart';

// ignore: camel_case_types
class premier_pas_2 extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const premier_pas_2({this.app});
  final FirebaseApp app;
  @override
  _premier_pas_2State createState() => _premier_pas_2State();
}

// ignore: camel_case_types
class _premier_pas_2State extends State<premier_pas_2> {
  var player = AudioCache();
  String deviceName = '';
  String deviceVersion = '';
  String identifier = '';
  String avatar = './assets/img/avatar_1.png';
  static const double _shadowHeight = 4;
  double _position = 6;
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
    final snapshot3 = await ref.child('$identifier/Enfant/Avatar').get();
    if (snapshot.value == identifier) {
      setState(() {
        avatar = snapshot3.value;
      });
    } else {
      setState(() {
        avatar = './assets/img/avatar_1.png';
      });
    }
  }

  final referenceDatabase = FirebaseDatabase.instance;

  var remove = RemoveEmoji();

  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    getData();
    _deviceDetails();
    final ref = referenceDatabase.reference();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/img/page_kid.png"),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Container(
                margin: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: const retour(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: height / 15,
                    ),
                    AppText(
                      text: "Espace du profil de l'enfant",
                      size: width / 10,
                    ),
                    SizedBox(
                      height: height / 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: AppText(
                              text: "Choisir un avatar",
                              size: width / 10,
                            ),
                            content: const gridAvatar(),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: AppText(
                                  text: "Annuler",
                                  size: width / 12,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      // Image tapped
                      child: Container(
                          margin: const EdgeInsets.all(10),
                          width: width / 2,
                          height: width / 2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(
                                  // ignore: unnecessary_string_interpolations
                                  image: AssetImage("$avatar"),
                                  fit: BoxFit.cover))),
                    ),
                    SizedBox(
                      height: height / 40,
                    ),
                    AppText(
                      text: "Ton nom",
                      size: width / 12,
                    ),
                    SizedBox(
                      height: height / 100,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: TextField(
                            controller: myController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            showCursor: true,
                            style: TextStyle(fontSize: width / 12),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 14),
                            ))),
                    SizedBox(
                      height: height / 40,
                    ),
                    GestureDetector(
                      onTapUp: (_) {
                        setState(() {
                          _position = 6;
                        });
                        player.play('sfx/poop.mp3');
                        if (remove.removemoji(myController.text
                                .replaceAll(RegExp('[^A-Za-z]'), '')) !=
                            myController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: AppText(
                              text:
                                  'Le nom ne peut pas contenir des symboles, des espaces, des chiffres ou des emojis',
                              size: width / 22,
                              color: Colors.white,
                            ),
                          ));
                        } else if (myController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: AppText(
                              text: 'Veillez saisir un nom',
                              size: width / 22,
                              color: Colors.white,
                            ),
                          ));
                        } else {
                          ref.update({
                            "$identifier/Enfant/Nom": remove.removemoji(
                                myController.text
                                    .replaceAll(RegExp('[^A-Za-z-_]'), '')),
                            "$identifier/Enfant/Score": '0',
                            "$identifier/Enfant/TempsJeu": '25',
                            "$identifier/Enfant/TempsPause": '5',
                          });
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const acceil()));
                        }
                      },
                      onTapDown: (_) {
                        setState(() {
                          _position = 0;
                        });
                      },
                      onTapCancel: () {
                        setState(() {
                          _position = 6;
                        });
                      },
                      child: SizedBox(
                        height: 60 + _shadowHeight + 10,
                        width: 200,
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              child: Container(
                                height: 60,
                                width: 200,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 21, 97, 158),
                                  // ignore: unnecessary_const
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                ),
                              ),
                            ),
                            AnimatedPositioned(
                              curve: Curves.easeIn,
                              bottom: _position,
                              duration: const Duration(milliseconds: 70),
                              child: Container(
                                height: 60,
                                width: 200,
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                ),
                                child: Center(
                                  child: AppText(
                                    text: "Suivant",
                                    size: width / 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          )),
    );
  }

  Widget buildImg() => GestureDetector(onTap: () {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Choisir un avatar"),
            content: const Text("Selectionner un avatar"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text("valider"),
              ),
            ],
          ),
        );
      });
}
