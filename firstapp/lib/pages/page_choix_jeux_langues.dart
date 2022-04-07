import 'package:firstapp/widgets/app_text.dart';
import 'package:firstapp/widgets/menue_retour.dart';
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
              image: AssetImage("assets/img/page_parametres.png"),
              fit: BoxFit.cover)),
      child: Column(children: [
        const retour(),
        SizedBox(
          height: height / 2.5,
        ),
        Opacity(
            opacity: 0.8,
            child: SizedBox(
              width: width,
              height: height / 19,
              child: AppText(
                text: "Cette partie est en cours de construction !",
                size: 30,
                color: Colors.black,
              ),
            )),
        const SizedBox(
          height: 10,
        ),
        const Center(
          child: CircularProgressIndicator(
            strokeWidth: 10,
            color: Color.fromARGB(255, 111, 195, 255),
          ),
        ),
      ]),
    ));
  }
}
