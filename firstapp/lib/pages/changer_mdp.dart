import 'package:firstapp/widgets/app_text.dart';
import 'package:firstapp/widgets/champ_mdp.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class changerMdp extends StatefulWidget {
  const changerMdp({Key key}) : super(key: key);

  @override
  _changerMdpState createState() => _changerMdpState();
}

// ignore: camel_case_types
class _changerMdpState extends State<changerMdp> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
              margin: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 70),
                    child: AppText(text: "Espace de contrôle parental"),
                  ),
                  SizedBox(
                    height: width / 1.3,
                  ),
                  AppText(
                    text: "Modifier le mot de passe",
                    size: 30,
                  ),
                  SizedBox(
                    width: width / 1.5,
                    height: width / 6,
                    child: const champMdp(),
                  ),
                  SizedBox(
                    height: width / 8,
                  ),
                  SizedBox(
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
