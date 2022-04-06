import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firstapp/pages/acceuil_ou_premier_pas.dart';
import 'package:firstapp/pages/page_acceuil.dart';
import 'package:firstapp/pages/page_premier_pas_1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

import 'jeux/Quiz/quiz.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  Future<File> get _localFile async {
    return File('assets/infos_app/is_oppend.txt');
  }

  Future<String> readFile() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return contents.toString();
    } catch (e) {
      // If encountering an error, return 0
      return "false";
    }
  }

  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Dongle',
        ),
        home: FutureBuilder(
          future: _fbApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print('ERROR : ${snapshot.error.toString()}');
              return Text("ERRORRRR !");
            } else if (snapshot.hasData) {
              return oppened();
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
        //premier_pas_1(),
        );
  }
}
