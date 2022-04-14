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
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        // ignore: missing_required_param
        floatingActionButton: const FloatingActionButton(
          mini: false,
          shape: RoundedRectangleBorder(),
          child: retour(
            color: Colors.white,
          ),
          backgroundColor: Colors.transparent,
          splashColor: Colors.transparent,
          elevation: 0,
          hoverElevation: 0,
          focusElevation: 0,
          highlightElevation: 0,
        ),
        body: SafeArea(
          child: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/img/page_parametres.png"),
                    fit: BoxFit.cover)),
            child: SingleChildScrollView(
              child: Column(children: [
                const SizedBox(
                  height: 110,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      AppMsg(
                        text:
                            "Cette application a été créer pour un projet universitaire",
                        size: 25,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      AppMsg(
                        text:
                            "Le code complet de l’application est disponible sur la page GitHub :",
                        size: 25,
                        color: Colors.blue,
                      ),
                      AppMsg(
                        text: "github.com/NiemaAM/PFE",
                        size: 25,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      AppMsg(
                        text: "Créateur :",
                        size: 25,
                        color: Colors.blue,
                      ),
                      AppMsg(
                        text: "nam",
                        size: 25,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      AppMsg(
                        text: "App UI :",
                        size: 25,
                        color: Colors.blue,
                      ),
                      AppMsg(
                        text: "nam",
                        size: 25,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      AppMsg(
                        text: "Framework :",
                        size: 25,
                        color: Colors.blue,
                      ),
                      AppMsg(
                        text: "Flutter",
                        size: 25,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      AppMsg(
                        text: "Base de données :",
                        size: 25,
                        color: Colors.blue,
                      ),
                      AppMsg(
                        text: "Firebase Real Time Database",
                        size: 25,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      AppMsg(
                        text: "Images et icones :",
                        size: 25,
                        color: Colors.blue,
                      ),
                      AppMsg(
                        text: "flaticon.com",
                        size: 25,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      AppMsg(
                        text: "Musique du jeu :",
                        size: 25,
                        color: Colors.blue,
                      ),
                      AppMsg(
                        text: "HeatleyBros youtu.be/wsrQogUxOIA",
                        size: 25,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      AppMsg(
                        text: "Livres audios :",
                        size: 25,
                        color: Colors.blue,
                      ),
                      AppMsg(
                        text: "bibliboom.com",
                        size: 25,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      AppMsg(
                        text: "Références :",
                        size: 25,
                        color: Colors.blue,
                      ),
                      AppMsg(
                        text:
                            "Page de dessin inspirer par Priyanka Tyagi \nPuzzles inspirer par Shidi Studio",
                        size: 25,
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
          ),
        ));
  }
}
