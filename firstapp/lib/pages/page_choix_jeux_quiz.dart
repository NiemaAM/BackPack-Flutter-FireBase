import 'package:firstapp/widgets/app_text.dart';
import 'package:firstapp/widgets/grid_jeux_quiz.dart';
import 'package:firstapp/widgets/menue_retour.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class pageQuizChoix extends StatefulWidget {
  const pageQuizChoix({Key key}) : super(key: key);

  @override
  _pageQuizChoixState createState() => _pageQuizChoixState();
}

// ignore: camel_case_types
class _pageQuizChoixState extends State<pageQuizChoix> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/img/page_jeux_choix_2.png"),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Column(children: [
            // ignore: sdk_version_ui_as_code
            if (height < 700)
              const retour(
                color: Colors.black,
              ),
            // ignore: sdk_version_ui_as_code
            if (height > 700)
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
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                  ),
                  child: AppText(
                    text: "Choisi le quiz que tu veux !",
                    color: Colors.black,
                  ),
                )),
            SizedBox(
              width: width,
              height: height / 1.3,
              child: const gridquiz(),
            )
          ]),
        ),
      ),
    ));
  }
}
