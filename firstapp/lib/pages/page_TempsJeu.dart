// ignore_for_file: deprecated_member_use, file_names
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firstapp/widgets/app_text.dart';
import 'package:flutter/services.dart';
import '../widgets/menue_retour.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

// ignore: camel_case_types
class TempsJeu extends StatefulWidget {
  const TempsJeu({Key key}) : super(key: key);

  @override
  _TempsJeuState createState() => _TempsJeuState();
}

// ignore: camel_case_types
class _TempsJeuState extends State<TempsJeu> {
  var player = AudioCache();
  int valeur = 25;
  bool min = true;
  bool max = true;
  final referenceDatabase = FirebaseDatabase.instance;
  String deviceName = '';
  String deviceVersion = '';
  String identifier = '';
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

  checkValeur() {
    setState(() {
      if (valeur == 60) {
        max = false;
      }
      if (valeur < 60) {
        max = true;
      }
      if (valeur == 25) {
        min = false;
      }
      if (valeur > 25) {
        min = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ref = referenceDatabase.reference();
    _deviceDetails();
    checkValeur();
    const double _height = 64 - _shadowHeight;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          color: Colors.white,
          child: SingleChildScrollView(
              child: Column(
            children: [
              const retour(
                color: Colors.black,
              ),
              SizedBox(
                height: height / 4,
              ),
              AppText(
                text: "Temps de jeu",
                size: width / 10,
                color: Colors.black87,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 100,
                      height: 90,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: const Color.fromARGB(255, 230, 230, 230),
                      ),
                      child: AppText(
                        text: "$valeur",
                        size: width / 5,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (valeur < 60) {
                              valeur = valeur + 1;
                            }
                          });
                        },
                        child: Container(
                          width: 40,
                          height: 42.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: (max) ? Colors.blue : Colors.grey,
                          ),
                          child: const Icon(
                            Icons.arrow_drop_up,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (valeur > 25) {
                              valeur = valeur - 1;
                            }
                          });
                        },
                        child: Container(
                          width: 40,
                          height: 42.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: (min) ? Colors.blue : Colors.grey,
                          ),
                          child: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTapUp: (_) {
                  setState(() {
                    _position = 6;
                  });
                  player.play('sfx/poop.mp3');
                  ref.update({
                    "$identifier/Enfant/TempsJeu": "$valeur",
                  });
                  Navigator.of(context).pop();
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
                              text: "Valider",
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
        ),
      ),
    );
  }
}
