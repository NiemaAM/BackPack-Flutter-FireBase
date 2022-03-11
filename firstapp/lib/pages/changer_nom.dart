import 'package:firstapp/widgets/app_text.dart';
import 'package:firstapp/widgets/champ_text.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class changernom extends StatefulWidget {
  const changernom({Key key}) : super(key: key);

  @override
  _changernomState createState() => _changernomState();
}

// ignore: camel_case_types
class _changernomState extends State<changernom> {
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
                  SizedBox(
                    height: width / 15,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 70),
                    child: AppText(text: "Espace du profil de l'enfant"),
                  ),
                  SizedBox(
                    height: width / 2,
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
                          Navigator.of(context).pop();
                        },
                        child: AppText(
                          text: "Modifier",
                          size: 40,
                          color: Colors.white,
                        ),
                      )),
                ],
              ))),
    );
  }
}
