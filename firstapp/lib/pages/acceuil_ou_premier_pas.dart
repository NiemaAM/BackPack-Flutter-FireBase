import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firstapp/pages/page_acceuil.dart';
import 'package:firstapp/pages/page_premier_pas_1.dart';
import 'package:firebase_database/firebase_database.dart';
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
    final snapshot2 = await ref.child('$identifier/Enfant/Nom').get();
    String nom = snapshot2.value;
    if (snapshot.value == identifier && nom.isNotEmpty) {
      setState(() {
        isoppend = 1;
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
      return const Center(
        child: CircularProgressIndicator(),
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
