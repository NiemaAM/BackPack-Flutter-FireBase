import 'package:firstapp/pages/page_acceuil.dart';
import 'package:firstapp/widgets/app_text.dart';
import 'package:firstapp/widgets/champ_text.dart';
import 'package:firstapp/widgets/menue_retour.dart';
import 'package:firstapp/widgets/slide_avatar_choix.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class premier_pas_2 extends StatefulWidget {
  const premier_pas_2({Key key}) : super(key: key);

  @override
  _premier_pas_2State createState() => _premier_pas_2State();
}

// ignore: camel_case_types
class _premier_pas_2State extends State<premier_pas_2> {
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
                  image: AssetImage("assets/img/page_kid.png"),
                  fit: BoxFit.cover)),
          child: Container(
              margin: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: retour(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: width / 15,
                  ),
                  AppText(text: "Espace du profil de l'enfant"),
                  Container(
                    height: width / 1.5,
                    child: avatarChoix(),
                  ),
                  AppText(
                    text: "Ton nom",
                    size: 30,
                  ),
                  Container(
                    width: width / 1.5,
                    height: width / 6,
                    child: champText(),
                  ),
                  SizedBox(
                    height: width / 8,
                  ),
                  Container(
                      width: width / 3,
                      height: width / 7,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => acceil()));
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
