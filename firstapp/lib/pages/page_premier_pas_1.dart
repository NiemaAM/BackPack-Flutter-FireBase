import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firstapp/pages/page_premier_pas_2.dart';
import 'package:firstapp/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remove_emoji/remove_emoji.dart';

// ignore: camel_case_types
class premier_pas_1 extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const premier_pas_1({this.app});
  final FirebaseApp app;

  @override
  _premier_pas_1State createState() => _premier_pas_1State();
}

// ignore: camel_case_types
class _premier_pas_1State extends State<premier_pas_1> {
  var player = AudioCache();
  String deviceName = '';
  String deviceVersion = '';
  String identifier = '';
  static const double _shadowHeight = 4;
  double _position = 6;
  bool cacher = true;
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

  final referenceDatabase = FirebaseDatabase.instance;
  // ignore: non_constant_identifier_names
  String Nom = "mdp";

  var remove = RemoveEmoji();
  String idParent = "${Random().nextInt(100)}";
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    final ref = referenceDatabase.reference();
    _deviceDetails();
    const double _height = 64 - _shadowHeight;
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
                margin: const EdgeInsets.all(30),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(
                      height: height / 15,
                    ),
                    AppText(
                      text: "Espace de contrôle parental",
                      size: width / 10,
                    ),
                    Image.asset(
                      "assets/img/img_parents.png",
                    ),
                    SizedBox(
                      height: height / 30,
                    ),
                    AppText(
                      text: "Creér un mot de passe",
                      size: width / 12,
                    ),
                    SizedBox(
                      height: height / 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: TextField(
                          controller: myController,
                          obscureText: cacher,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          showCursor: true,
                          style: TextStyle(fontSize: width / 12),
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 14),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  cacher
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    cacher = !cacher;
                                  });
                                },
                              ))),
                    ),
                    SizedBox(
                      height: height / 40,
                    ),
                    GestureDetector(
                      onTapUp: (_) {
                        setState(() {
                          _position = 6;
                        });
                        player.play('sfx/poop.mp3');
                        if (remove.removemoji(myController.text) !=
                            myController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: AppText(
                              text:
                                  'Le mot de passe ne peut pas contenir des emojis',
                              size: width / 22,
                              color: Colors.white,
                            ),
                          ));
                        } else if (myController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: AppText(
                              text: 'Veillez saisir un mot de passe parentale',
                              size: width / 22,
                              color: Colors.white,
                            ),
                          ));
                        } else if (remove.removemoji(myController.text).length <
                            5) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: AppText(
                              text:
                                  'Le mot de passe doit contenir minimum 5 caractéres',
                              size: width / 22,
                              color: Colors.white,
                            ),
                          ));
                        } else {
                          _deviceDetails();
                          ref.update({
                            identifier: {
                              "MotDePasse":
                                  remove.removemoji(myController.text),
                              "id": identifier,
                              "Enfant": {
                                "Nom": "",
                                "Avatar": "./assets/img/avatar_1.png",
                              }
                            }
                          });
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const premier_pas_2()));
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
                        height: _height + _shadowHeight + 10,
                        width: 200,
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              child: Container(
                                height: _height,
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
                                height: _height,
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
}
