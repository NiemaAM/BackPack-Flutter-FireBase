import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: camel_case_types
class gridAvatar extends StatefulWidget {
  const gridAvatar({Key key}) : super(key: key);

  @override
  _gridAvatarState createState() => _gridAvatarState();
}

// ignore: camel_case_types
class _gridAvatarState extends State<gridAvatar> {
  List imgs = [
    "./assets/img/avatar_1.png",
    "./assets/img/avatar_2.png",
    "./assets/img/avatar_3.png",
    "./assets/img/avatar_4.png",
    "./assets/img/avatar_5.png",
    "./assets/img/avatar_6.png"
  ];
  String deviceName = '';
  String deviceVersion = '';
  String identifier = '';
  String avatar = './assets/img/avatar_1.png';
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
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    _deviceDetails();
    // ignore: deprecated_member_use
    final ref = referenceDatabase.reference();
    return SizedBox(
      height: 150,
      width: width,
      child: Column(
        children: <Widget>[
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    ref.update({
                      "$identifier/Enfant/Avatar": imgs[0],
                    });
                    Navigator.of(context).pop();
                  },
                  child: Image.asset(imgs[0], height: 75)),
              GestureDetector(
                  onTap: () {
                    ref.update({
                      "$identifier/Enfant/Avatar": imgs[1],
                    });
                    Navigator.of(context).pop();
                  },
                  child: Image.asset(imgs[1], height: 75)),
              GestureDetector(
                  onTap: () {
                    ref.update({
                      "$identifier/Enfant/Avatar": imgs[2],
                    });
                    Navigator.of(context).pop();
                  },
                  child: Image.asset(imgs[2], height: 75)),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    ref.update({
                      "$identifier/Enfant/Avatar": imgs[3],
                    });
                    Navigator.of(context).pop();
                  },
                  child: Image.asset(imgs[3], height: 75)),
              GestureDetector(
                  onTap: () {
                    ref.update({
                      "$identifier/Enfant/Avatar": imgs[4],
                    });
                    Navigator.of(context).pop();
                  },
                  child: Image.asset(imgs[4], height: 75)),
              GestureDetector(
                  onTap: () {
                    ref.update({
                      "$identifier/Enfant/Avatar": imgs[5],
                    });
                    Navigator.of(context).pop();
                  },
                  child: Image.asset(imgs[5], height: 75)),
            ],
          ),
        ],
      ),
    );
  }
}
