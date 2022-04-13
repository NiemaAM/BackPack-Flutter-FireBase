import 'dart:io';
import 'dart:math';

import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firstapp/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remove_emoji/remove_emoji.dart';

import '../widgets/menue_retour.dart';

// ignore: camel_case_types
class modifier_mot_de_passe extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const modifier_mot_de_passe({this.app});
  final FirebaseApp app;

  @override
  _modifier_mot_de_passeState createState() => _modifier_mot_de_passeState();
}

// ignore: camel_case_types
class _modifier_mot_de_passeState extends State<modifier_mot_de_passe> {
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
                AppText(text: "Espace de contrôle parental"),
                Image.asset("assets/img/img_parents.png"),
                SizedBox(
                  height: height / 30,
                ),
                AppText(
                  text: "Modifier le mot de passe",
                  size: 30,
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
                      style: const TextStyle(fontSize: 30),
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 14),
                          suffixIcon: IconButton(
                            icon: Icon(
                              cacher ? Icons.visibility : Icons.visibility_off,
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
                    if (remove.removemoji(myController.text) !=
                        myController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: AppText(
                          text:
                              'Le mot de passe ne peut pas contenir des emojis',
                          size: 15,
                          color: Colors.white,
                        ),
                      ));
                    } else if (myController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: AppText(
                          text: 'Veillez saisir un mot de passe parentale',
                          size: 15,
                          color: Colors.white,
                        ),
                      ));
                    } else if (remove.removemoji(myController.text).length <
                        5) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: AppText(
                          text:
                              'Le mot de passe doit contenir minimum 5 caractéres',
                          size: 15,
                          color: Colors.white,
                        ),
                      ));
                    } else {
                      _deviceDetails();
                      ref.update({
                        "$identifier/MotDePasse":
                            remove.removemoji(myController.text),
                      });
                      Navigator.of(context).pop();
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
                                text: "Valider",
                                size: 30,
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
    );
  }
}
