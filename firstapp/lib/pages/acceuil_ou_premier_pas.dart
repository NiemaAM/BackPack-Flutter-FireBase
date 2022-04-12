import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firstapp/pages/page_acceuil.dart';
import 'package:firstapp/pages/page_premier_pas_1.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firstapp/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: camel_case_types
class oppened extends StatefulWidget {
  const oppened({Key key}) : super(key: key);

  @override
  oppenedState createState() => oppenedState();
}

// ignore: camel_case_types
class oppenedState extends State<oppened> {
  int isoppend = 3;
  String nom = 'nom';
  String mdp = 'mdp';
  String avatar = './assets/img/avatar_1.png';
  String val = "";

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
    setState(() {
      val = snapshot.value;
    });
    await Future.delayed(const Duration(seconds: 2), () {});
    if (val == identifier) {
      setState(() {
        isoppend = 1;
        mdp = snapshot1.value;
        nom = snapshot2.value;
        avatar = snapshot3.value;
      });
    } else {
      setState(() {
        isoppend = 0;
      });
    }
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    // ignore: unrelated_type_equality_checks
    _deviceDetails();
    getData();
    if (isoppend == 3) {
      return SafeArea(
        child: Container(
          color: Colors.white,
          width: double.maxFinite,
          height: double.maxFinite,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Container()),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                      // ignore: unnecessary_string_interpolations
                      image: AssetImage("assets/img/logo_app.png"),
                      fit: BoxFit.cover),
                ),
              ),
              Expanded(child: Container()),
              const CircularProgressIndicator(),
              const SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      );
    }
    if (isoppend == 1) {
      return const acceil();
    }
    if (isoppend == 0) {
      return const premier_pas_1();
    }
  }
}
