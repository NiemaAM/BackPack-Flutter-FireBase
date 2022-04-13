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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                size: 40,
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color.fromARGB(255, 230, 230, 230),
                    ),
                    child: Center(
                        child: AppText(
                      text: "$valeur",
                      size: 70,
                    )),
                  ),
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
              SizedBox(
                  width: 150,
                  height: width / 7,
                  child: ElevatedButton(
                    onPressed: () {
                      ref.update({
                        "$identifier/Enfant/TempsJeu": "$valeur",
                      });
                      Navigator.of(context).pop();
                    },
                    child: AppText(
                      text: "Valider",
                      size: 40,
                      color: Colors.white,
                    ),
                  )),
            ],
          )),
        ),
      ),
    );
  }
}
