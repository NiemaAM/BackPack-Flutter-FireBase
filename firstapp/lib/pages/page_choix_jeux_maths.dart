import 'package:firstapp/widgets/app_text.dart';
import 'package:firstapp/widgets/menue_retour.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class pageMathChoix extends StatefulWidget {
  const pageMathChoix({Key key}) : super(key: key);

  @override
  _pageMathChoixState createState() => _pageMathChoixState();
}

// ignore: camel_case_types
class _pageMathChoixState extends State<pageMathChoix> {
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
        const retour(
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
