import 'dart:io';

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
  String deviceName = '';
  String deviceVersion = '';
  String identifier = '';
  String mdp = "";
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
      body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/img/page_parents.png"),
                  fit: BoxFit.cover)),
          child: Container(
              margin: const EdgeInsets.all(30),
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
                    height: height / 2.5,
                  ),
                  SizedBox(
                      width: width,
                      height: width / 10,
                      child: AppText(
                        text: "Entrer le mot de passe parental",
                        size: 30,
                      )),
                  SizedBox(
                    width: width / 1.5,
                    height: width / 6,
                    child: TextField(
                      controller: myController,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      showCursor: true,
                      style: const TextStyle(fontSize: 30),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.password),
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
                          getData();
                          if (mdp.length > 2) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: AppText(
                                text: 'Mot de passe incorrecte ',
                                size: 15,
                                color: Colors.white,
                              ),
                            ));
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const parametres()));
                          }
                        },
                        child: AppText(
                          text: "Suivant",
                          size: 40,
                          color: Colors.white,
                        ),
                      )),
                ],
              ))),
    );
  }
}
