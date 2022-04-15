import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firstapp/pages/page_parametres.dart';
import 'package:firstapp/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remove_emoji/remove_emoji.dart';

import '../widgets/menue_retour.dart';

// ignore: camel_case_types
class verifier_mot_de_passe extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const verifier_mot_de_passe({this.app});
  final FirebaseApp app;

  @override
  _verifier_mot_de_passeState createState() => _verifier_mot_de_passeState();
}

// ignore: camel_case_types
class _verifier_mot_de_passeState extends State<verifier_mot_de_passe> {
  var player = AudioCache();
  String deviceName = '';
  String deviceVersion = '';
  String identifier = '';
  String mdp = "";
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

  getData() async {
    _deviceDetails();
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('$identifier/MotDePasse').get();
    if (snapshot.value == myController.text) {
      setState(() {
        mdp = "1";
      });
    } else {
      setState(() {
        mdp = "10000";
      });
    }
  }

  final referenceDatabase = FirebaseDatabase.instance;

  var remove = RemoveEmoji();
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _deviceDetails();
    getData();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
          child: Container(
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
                    text: "Espace de contrôle parental",
                    size: width / 10,
                  ),
                  Image.asset("assets/img/img_parents.png"),
                  SizedBox(
                    height: height / 30,
                  ),
                  AppText(
                    text: "Mot de passe parental",
                    size: width / 12,
                  ),
                  SizedBox(
                    height: height / 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60, right: 60),
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
                      player.play('sfx/poop.mp3');
                      setState(() {
                        _position = 6;
                      });
                      getData();
                      if (mdp.length > 2) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: AppText(
                            text: 'Mot de passe incorrecte',
                            size: width / 22,
                            color: Colors.white,
                          ),
                        ));
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const parametres()));
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
                  ),
                ],
              ))),
    );
  }
}
