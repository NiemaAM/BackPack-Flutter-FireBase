import 'dart:math';
import 'dart:async';
import 'dart:io';

import 'package:firstapp/pages/page_acceuil.dart';
import 'package:firstapp/pages/page_premier_pas_1.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:firebase_database/firebase_database.dart';
import 'package:firstapp/pages/page_premier_pas_2.dart';
import 'package:firstapp/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remove_emoji/remove_emoji.dart';
import 'package:path_provider/path_provider.dart';

// ignore: camel_case_types
class oppened extends StatefulWidget {
  const oppened({Key key}) : super(key: key);

  @override
  oppenedState createState() => oppenedState();
}

// ignore: camel_case_types
class oppenedState extends State<oppened> {
  String isoppend = '';
  getData() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('Parent/id').get();
    if (snapshot.exists) {
      setState(() {
        isoppend = "1";
      });
    } else {
      setState(() {
        isoppend = "1000";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unrelated_type_equality_checks
    getData();
    if (isoppend.length > 2) {
      return premier_pas_1();
    } else {
      return acceil();
    }
  }
}
