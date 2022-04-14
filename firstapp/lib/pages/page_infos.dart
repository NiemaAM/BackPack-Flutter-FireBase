// ignore_for_file: unnecessary_string_escapes

import 'package:firstapp/widgets/app_msg.dart';
import 'package:firstapp/widgets/floating_retour.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class PageInfos extends StatefulWidget {
  const PageInfos({Key key}) : super(key: key);

  @override
  _PageInfosState createState() => _PageInfosState();
}

// ignore: camel_case_types
class _PageInfosState extends State<PageInfos> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        // ignore: missing_required_param
        floatingActionButton: const FloatingActionButton(
          mini: false,
          shape: RoundedRectangleBorder(),
          child: retour(
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          splashColor: Colors.transparent,
          elevation: 0,
          hoverElevation: 0,
          focusElevation: 0,
          highlightElevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(
                height: 70,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppMsg(
                      text:
                          "Cette application a été créer pour un projet universitaire \nCette application ne collecte aucune information personnelle autre que l'identifiant de votre appareil",
                      size: width / 14,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: width / 14,
                    ),
                    AppMsg(
                      text:
                          "Le code complet de l’application est disponible sur la page GitHub :",
                      size: width / 14,
                      color: Colors.blue,
                    ),
                    AppMsg(
                      text: "github.com/NiemaAM/PFE",
                      size: width / 14,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: width / 14,
                    ),
                    AppMsg(
                      text: "Créateur :",
                      size: width / 14,
                      color: Colors.blue,
                    ),
                    AppMsg(
                      text: "nam",
                      size: width / 14,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: width / 14,
                    ),
                    AppMsg(
                      text: "App UI :",
                      size: width / 14,
                      color: Colors.blue,
                    ),
                    AppMsg(
                      text: "nam",
                      size: width / 14,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: width / 14,
                    ),
                    AppMsg(
                      text: "Framework :",
                      size: width / 14,
                      color: Colors.blue,
                    ),
                    AppMsg(
                      text: "Flutter",
                      size: width / 14,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: width / 14,
                    ),
                    AppMsg(
                      text: "Base de données :",
                      size: width / 14,
                      color: Colors.blue,
                    ),
                    AppMsg(
                      text: "Firebase Real Time Database",
                      size: width / 14,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: width / 14,
                    ),
                    AppMsg(
                      text: "Images et icones :",
                      size: width / 14,
                      color: Colors.blue,
                    ),
                    AppMsg(
                      text: "flaticon.com",
                      size: width / 14,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: width / 14,
                    ),
                    AppMsg(
                      text: "Musique du jeu :",
                      size: width / 14,
                      color: Colors.blue,
                    ),
                    AppMsg(
                      text: "HeatleyBros youtu.be/wsrQogUxOIA",
                      size: width / 14,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: width / 14,
                    ),
                    AppMsg(
                      text: "Livres audios :",
                      size: width / 14,
                      color: Colors.blue,
                    ),
                    AppMsg(
                      text: "bibliboom.com",
                      size: width / 14,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: width / 14,
                    ),
                    AppMsg(
                      text: "Références :",
                      size: width / 14,
                      color: Colors.blue,
                    ),
                    AppMsg(
                      text:
                          "Page de dessin inspirer par Priyanka Tyagi \nPuzzles inspirer par Shidi Studio",
                      size: width / 14,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ]),
          ),
        ));
  }
}
