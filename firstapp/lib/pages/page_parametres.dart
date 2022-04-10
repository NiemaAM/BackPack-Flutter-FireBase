// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firstapp/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/menue_retour_parametres.dart';
import 'modifier_mot_de_passe.dart';
import 'modifier_profile_enfant.dart';

// ignore: camel_case_types
class parametres extends StatefulWidget {
  const parametres({Key key}) : super(key: key);

  @override
  _parametresState createState() => _parametresState();
}

// ignore: camel_case_types
class _parametresState extends State<parametres> {
  String nom = " ";
  String avatar = './assets/img/avatar_1.png';

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

  getData() async {
    _deviceDetails();
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('$identifier/Enfant/Nom').get();
    final snapshot2 = await ref.child('$identifier/Enfant/Avatar').get();
    setState(() {
      nom = snapshot.value;
      avatar = snapshot2.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/img/page_parametres.png"),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(children: [
              // ignore: sdk_version_ui_as_code
              if (height < 700)
                const retour(
                  color: Colors.black,
                ),
              // ignore: sdk_version_ui_as_code
              if (height > 700)
                const retour(
                  color: Colors.white,
                ),
              SizedBox(
                height: height / 14,
                width: width,
              ),
              AppText(
                text: "Paramètres du profil de l'enfant",
                color: const Color.fromARGB(255, 20, 111, 186),
              ),
              SizedBox(
                  width: width,
                  height: 40,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              const modifier_profile_enfant()));
                    },
                    child: AppText(
                      text: "Modifier le profile",
                      size: 30,
                      color: Colors.black87,
                    ),
                    color: Colors.transparent,
                    splashColor: Colors.transparent,
                    elevation: 0,
                    hoverElevation: 0,
                    focusElevation: 0,
                    highlightElevation: 0,
                  )),
              Container(
                  margin: const EdgeInsets.all(10),
                  width: width / 2,
                  height: width / 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                          image: AssetImage(avatar), fit: BoxFit.cover))),
              SizedBox(
                height: 40,
                width: width,
                child: AppText(
                  // ignore: unnecessary_string_interpolations
                  text: "$nom",
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                height: height / 50,
                width: width,
              ),
              AppText(
                text: 'Paramètres de contrôle parental',
                color: const Color.fromARGB(255, 20, 111, 186),
              ),
              SizedBox(
                height: height / 250,
                width: width,
              ),
              SizedBox(
                width: width,
                height: 40,
                child: RaisedButton(
                  onPressed: () {
                    showCupertinoDialog<void>(
                      context: context,
                      builder: (BuildContext context) => CupertinoAlertDialog(
                        title: AppText(text: 'Temps de jeu par jour', size: 20),
                        actions: <CupertinoDialogAction>[
                          CupertinoDialogAction(
                            child: const Text('Annuler'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          CupertinoDialogAction(
                            child: const Text('Valider'),
                            isDestructiveAction: true,
                            onPressed: () {
                              // Do something destructive.
                            },
                          )
                        ],
                      ),
                    );
                  },
                  child: AppText(
                    text: "Temps maximum de jeu par jour",
                    size: 30,
                    color: Colors.black87,
                  ),
                  color: Colors.transparent,
                  splashColor: Colors.transparent,
                  elevation: 0,
                  hoverElevation: 0,
                  focusElevation: 0,
                  highlightElevation: 0,
                ),
              ),
              SizedBox(
                height: height / 100,
                width: width,
              ),
              SizedBox(
                width: width,
                height: 40,
                child: RaisedButton(
                  onPressed: () {
                    showCupertinoDialog<void>(
                      context: context,
                      builder: (BuildContext context) => CupertinoAlertDialog(
                        title:
                            AppText(text: 'Temps entre chaque pause', size: 20),
                        actions: <CupertinoDialogAction>[
                          CupertinoDialogAction(
                            child: const Text('Annuler'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          CupertinoDialogAction(
                            child: const Text('Valider'),
                            isDestructiveAction: true,
                            onPressed: () {
                              // Do something destructive.
                            },
                          )
                        ],
                      ),
                    );
                  },
                  child: AppText(
                    text: "Temps entre chaque pause",
                    size: 30,
                    color: Colors.black87,
                  ),
                  color: Colors.transparent,
                  splashColor: Colors.transparent,
                  elevation: 0,
                  hoverElevation: 0,
                  focusElevation: 0,
                  highlightElevation: 0,
                ),
              ),
              SizedBox(
                height: height / 100,
                width: width,
              ),
              SizedBox(
                width: width,
                height: 40,
                child: RaisedButton(
                  onPressed: () {
                    showCupertinoDialog<void>(
                      context: context,
                      builder: (BuildContext context) => CupertinoAlertDialog(
                        title: AppText(text: 'Jeux bloqués', size: 20),
                        actions: <CupertinoDialogAction>[
                          CupertinoDialogAction(
                            child: const Text('Annuler'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          CupertinoDialogAction(
                            child: const Text('Valider'),
                            isDestructiveAction: true,
                            onPressed: () {
                              // Do something destructive.
                            },
                          )
                        ],
                      ),
                    );
                  },
                  child: AppText(
                    text: "Jeux bloqués",
                    size: 30,
                    color: Colors.black87,
                  ),
                  color: Colors.transparent,
                  splashColor: Colors.transparent,
                  elevation: 0,
                  hoverElevation: 0,
                  focusElevation: 0,
                  highlightElevation: 0,
                ),
              ),
              SizedBox(
                height: height / 30,
                width: width,
              ),
              SizedBox(
                  width: width,
                  height: 40,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const modifier_mot_de_passe()));
                    },
                    child: AppText(
                      text: "Changer le mot de passe",
                      size: 30,
                      color: Colors.redAccent,
                    ),
                    color: Colors.transparent,
                    splashColor: Colors.transparent,
                    elevation: 0,
                    hoverElevation: 0,
                    focusElevation: 0,
                    highlightElevation: 0,
                  )),
            ]),
          ),
        ),
      ),
    );
  }
}
