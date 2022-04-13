// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firstapp/widgets/app_text.dart';
import 'package:firstapp/widgets/menue_retour.dart';
import 'package:flutter/material.dart';
import 'package:remove_emoji/remove_emoji.dart';
import 'package:flutter/services.dart';

import '../widgets/grid_avatar_choix.dart';

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
  String avatar = './assets/img/blank.png';
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
    getData();
    final ref = referenceDatabase.reference();

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
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
                    AppText(text: "Espace du profil de l'enfant"),
                    SizedBox(
                      height: height / 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: AppText(text: "Choisir un avatar"),
                            content: const gridAvatar(),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: AppText(
                                  text: "Annuler",
                                  size: 30,
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
                      text: "Modifier le nom",
                      size: 30,
                    ),
                    SizedBox(
                      height: height / 100,
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
                      height: height / 40,
                    ),
                    SizedBox(
                        width: width / 3,
                        height: width / 7,
                        child: ElevatedButton(
                          onPressed: () {
                            if (remove.removemoji(myController.text
                                    .replaceAll(RegExp('[^A-Za-z]'), '')) !=
                                myController.text) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: AppText(
                                  text:
                                      'Le nom ne peut pas contenir des symboles, des espaces, des chiffres ou des emojis',
                                  size: 15,
                                  color: Colors.white,
                                ),
                              ));
                            } else if (myController.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
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
                )),
          )),
    );
  }
}
