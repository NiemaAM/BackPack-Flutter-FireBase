import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firstapp/widgets/app_text.dart';
import 'package:firstapp/widgets/menue_retour.dart';
import 'package:firstapp/widgets/slide_avatar_choix.dart';
import 'package:flutter/material.dart';
import 'package:remove_emoji/remove_emoji.dart';
import 'package:flutter/services.dart';

// ignore: camel_case_types
class modifier_profile_enfant extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const modifier_profile_enfant({this.app});
  final FirebaseApp app;
  @override
  _modifier_profile_enfantState createState() =>
      _modifier_profile_enfantState();
}

// ignore: camel_case_types
class _modifier_profile_enfantState extends State<modifier_profile_enfant> {
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

  final referenceDatabase = FirebaseDatabase.instance;

  var remove = RemoveEmoji();
  // ignore: non_constant_identifier_names
  String Nom = "Nom";
  String id = "id";

  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _deviceDetails();
    // ignore: deprecated_member_use
    final ref = referenceDatabase.reference();

    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/img/page_kid.png"),
                  fit: BoxFit.cover)),
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
                    height: width / 15,
                  ),
                  AppText(text: "Espace du profil de l'enfant"),
                  SizedBox(
                    height: width / 1.5,
                    child: const avatarChoix(),
                  ),
                  AppText(
                    text: "Modifier le nom",
                    size: 30,
                  ),
                  SizedBox(
                    width: width / 1.5,
                    height: width / 6,
                    child: TextField(
                      controller: myController,
                      style: const TextStyle(fontSize: 30),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: width / 8,
                  ),
                  SizedBox(
                      width: width / 3,
                      height: width / 7,
                      child: ElevatedButton(
                        onPressed: () {
                          if (remove.removemoji(myController.text
                                  .replaceAll(RegExp('[^A-Za-z]'), '')) !=
                              myController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: AppText(
                                text:
                                    'Le nom ne peut pas contenir des symboles, des espaces, des chiffres ou des emojis',
                                size: 15,
                                color: Colors.white,
                              ),
                            ));
                          } else if (myController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: AppText(
                                text: 'Veillez saisir un nom',
                                size: 15,
                                color: Colors.white,
                              ),
                            ));
                          } else {
                            ref.update({
                              "$identifier/Enfant/Nom": remove.removemoji(
                                  myController.text
                                      .replaceAll(RegExp('[^A-Za-z-_]'), '')),
                              "$identifier/Enfant/Avatar":
                                  './assets/img/avatar_1.png',
                            });
                            Navigator.of(context).pop();
                          }
                        },
                        child: AppText(
                          text: "Valider",
                          size: 40,
                          color: Colors.white,
                        ),
                      )),
                ],
              ))),
    );
  }
}
