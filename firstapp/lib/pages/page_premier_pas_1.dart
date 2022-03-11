import 'package:firstapp/pages/page_premier_pas_2.dart';
import 'package:firstapp/widgets/app_text.dart';
import 'package:firstapp/widgets/champ_mdp.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class premier_pas_1 extends StatefulWidget {
  const premier_pas_1({Key key}) : super(key: key);

  @override
  _premier_pas_1State createState() => _premier_pas_1State();
}

// ignore: camel_case_types
class _premier_pas_1State extends State<premier_pas_1> {
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
                  image: AssetImage("assets/img/page_parents.png"),
                  fit: BoxFit.cover)),
          child: Container(
              margin: const EdgeInsets.all(30),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    width: width,
                    height: height / 2,
                    child: AppText(text: "Espace de contrôle parental"),
                  ),
                  Container(
                      width: width,
                      height: width / 10,
                      child: AppText(
                        text: "Creér un mot de passe",
                        size: 30,
                      )),
                  Container(
                    width: width / 1.5,
                    height: width / 6,
                    child: champMdp(),
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
                              builder: (context) => premier_pas_2()));
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
