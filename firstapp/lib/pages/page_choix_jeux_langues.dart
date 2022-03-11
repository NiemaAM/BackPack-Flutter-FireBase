import 'package:firstapp/widgets/app_text.dart';
import 'package:firstapp/widgets/menue_retour.dart';
import 'package:firstapp/widgets/menue_retour_acceuil.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class pageLanguesChoix extends StatefulWidget {
  const pageLanguesChoix({Key key}) : super(key: key);

  @override
  _pageLanguesChoixState createState() => _pageLanguesChoixState();
}

// ignore: camel_case_types
class _pageLanguesChoixState extends State<pageLanguesChoix> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/img/page_jeux_choix_2.png"),
              fit: BoxFit.cover)),
      child: Column(children: [
        retouracceuil(
          color: Colors.white,
        ),
        SizedBox(
          height: height / 12,
        ),
        Opacity(
            opacity: 0.8,
            child: Container(
              width: width - 40,
              height: height / 19,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
              ),
              child: AppText(
                text: "Choisi ce que tu veux apprendre !",
                size: 35,
                color: Colors.black,
              ),
            )),
      ]),
    ));
  }
}
