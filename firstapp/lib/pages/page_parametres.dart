// ignore_for_file: deprecated_member_use

import 'package:firstapp/pages/changer_mdp.dart';
import 'package:firstapp/pages/changer_nom.dart';
import 'package:firstapp/widgets/app_text.dart';
import 'package:firstapp/widgets/slide_avatar_choix.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/menue_retour_parametres.dart';

// ignore: camel_case_types
class parametres extends StatefulWidget {
  const parametres({Key key}) : super(key: key);

  @override
  _parametresState createState() => _parametresState();
}

// ignore: camel_case_types
class _parametresState extends State<parametres> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/img/page_parametres.png"),
                fit: BoxFit.cover)),
        child: Column(children: [
          const retour(),
          SizedBox(
            height: height / 15,
          ),
          AppText(
            text: "Paramètres du profil de l'enfant",
          ),
          AppText(
            text: "Changer l'avatar",
            size: 30,
          ),
          SizedBox(
            height: height / 3.4,
            child: const avatarChoix(),
          ),
          SizedBox(
              width: width / 2,
              height: height / 30,
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const changernom()));
                },
                child: AppText(
                  text: "Changer le nom",
                  size: 30,
                  color: Colors.black,
                ),
                color: Colors.transparent,
                splashColor: Colors.transparent,
                elevation: 0,
                hoverElevation: 0,
                focusElevation: 0,
                highlightElevation: 0,
              )),
          SizedBox(
            height: height / 50,
          ),
          AppText(
            text: 'Paramètres de contrôle parental',
          ),
          SizedBox(
            height: height / 250,
          ),
          SizedBox(
            width: width,
            height: height / 30,
            child: RaisedButton(
              onPressed: () {
                showCupertinoDialog<void>(
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                    title: AppText(text: 'Temps de jeu par jour', size: 20),
                    actions: <CupertinoDialogAction>[
                      CupertinoDialogAction(
                        child: const Text('Annuler'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      CupertinoDialogAction(
                        child: const Text('Valider'),
                        isDestructiveAction: true,
                        onPressed: () {
                          // Do something destructive.
                        },
                      )
                    ],
                  ),
                );
              },
              child: AppText(
                text: "Temps maximum de jeu par jour",
                size: 30,
                color: Colors.black,
              ),
              color: Colors.transparent,
              splashColor: Colors.transparent,
              elevation: 0,
              hoverElevation: 0,
              focusElevation: 0,
              highlightElevation: 0,
            ),
          ),
          SizedBox(
            height: height / 100,
          ),
          SizedBox(
            width: width,
            height: height / 30,
            child: RaisedButton(
              onPressed: () {
                showCupertinoDialog<void>(
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                    title: AppText(text: 'Temps entre chaque pause', size: 20),
                    actions: <CupertinoDialogAction>[
                      CupertinoDialogAction(
                        child: const Text('Annuler'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      CupertinoDialogAction(
                        child: const Text('Valider'),
                        isDestructiveAction: true,
                        onPressed: () {
                          // Do something destructive.
                        },
                      )
                    ],
                  ),
                );
              },
              child: AppText(
                text: "Temps entre chaque pause",
                size: 30,
                color: Colors.black,
              ),
              color: Colors.transparent,
              splashColor: Colors.transparent,
              elevation: 0,
              hoverElevation: 0,
              focusElevation: 0,
              highlightElevation: 0,
            ),
          ),
          SizedBox(
            height: height / 100,
          ),
          SizedBox(
            width: width,
            height: height / 30,
            child: RaisedButton(
              onPressed: () {
                showCupertinoDialog<void>(
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                    title: AppText(text: 'Jeux bloqués', size: 20),
                    actions: <CupertinoDialogAction>[
                      CupertinoDialogAction(
                        child: const Text('Annuler'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      CupertinoDialogAction(
                        child: const Text('Valider'),
                        isDestructiveAction: true,
                        onPressed: () {
                          // Do something destructive.
                        },
                      )
                    ],
                  ),
                );
              },
              child: AppText(
                text: "Jeux bloqués",
                size: 30,
                color: Colors.black,
              ),
              color: Colors.transparent,
              splashColor: Colors.transparent,
              elevation: 0,
              hoverElevation: 0,
              focusElevation: 0,
              highlightElevation: 0,
            ),
          ),
          SizedBox(
            height: height / 30,
          ),
          SizedBox(
              width: width,
              height: height / 30,
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const changerMdp()));
                },
                child: AppText(
                  text: "Changer le mot de passe",
                  size: 30,
                  color: Colors.black,
                ),
                color: Colors.transparent,
                splashColor: Colors.transparent,
                elevation: 0,
                hoverElevation: 0,
                focusElevation: 0,
                highlightElevation: 0,
              )),
        ]),
      ),
    );
  }
}
