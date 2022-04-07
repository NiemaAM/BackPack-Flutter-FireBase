// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firstapp/pages/verifier_mot_de_passe.dart';
import 'package:firstapp/widgets/app_text.dart';
import 'package:firstapp/widgets/slide_jeux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/Audio_BK.dart';
import '../widgets/menue_infos.dart';

// ignore: camel_case_types
class acceil extends StatefulWidget {
  const acceil({Key key}) : super(key: key);

  @override
  _acceilState createState() => _acceilState();
}

// ignore: camel_case_types
class _acceilState extends State<acceil> {
  int isoppend = 3;
  String nom = '';
  String mdp = '';
  // ignore: non_constant_identifier_names
  String Avatar = './assets/img/avatar_1.png';

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
    final snapshot = await ref.child('$identifier/id').get();
    final snapshot1 = await ref.child('$identifier/MotDePasse').get();
    final snapshot2 = await ref.child('$identifier/Enfant/Nom').get();
    final snapshot3 = await ref.child('$identifier/Enfant/Avatar').get();
    if (snapshot.value == identifier) {
      setState(() {
        isoppend = 1;
        mdp = snapshot1.value;
        nom = snapshot2.value;
        Avatar = snapshot3.value;
      });
    } else {
      setState(() {
        isoppend = 0;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    Audio_BK.loopBK();
    return Scaffold(body: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;
        return Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/img/Main_fond.png"),
                  fit: BoxFit.cover)),
          child: Column(children: [
            Container(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: Row(
                children: [
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const verifier_mot_de_passe()));
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child:
                        Icon(Icons.menu, size: width / 8, color: Colors.white),
                    color: Colors.transparent,
                    splashColor: Colors.transparent,
                    elevation: 0,
                    hoverElevation: 0,
                    focusElevation: 0,
                    highlightElevation: 0,
                  ),
                  Expanded(child: Container()),
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    width: width / 5,
                    height: width / 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                          // ignore: unnecessary_string_interpolations
                          image: AssetImage("$Avatar"),
                          fit: BoxFit.cover),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: height / 20,
            ),
            SizedBox(
              height: height / 6,
              child: Center(
                child: AppText(
                    text: "Bonjour $nom, à quoi veux tu jouer aujourd'hui ?",
                    size: 35,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              width: width,
              height: height / 2,
              child: const slideJeux(),
            ),
            Container(
              margin: const EdgeInsets.only(right: 10, top: 50),
              child: const menueInfos(),
            )
          ]),
        );
      },
    ));
  }
}
