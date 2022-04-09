// ignore_for_file: deprecated_member_use
import 'package:firstapp/jeux/Langues/Anglais/fruits.dart';
import 'package:firstapp/widgets/app_text.dart';
import 'package:flutter/material.dart';

import '../jeux/Langues/Anglais/animaux.dart';
import '../jeux/Langues/Anglais/legumes.dart';
import '../widgets/menue_retour.dart';

// ignore: camel_case_types
class Francais extends StatefulWidget {
  const Francais({Key key}) : super(key: key);

  @override
  _FrancaisState createState() => _FrancaisState();
}

// ignore: camel_case_types
class _FrancaisState extends State<Francais> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/img/page_parametres.png"),
                  fit: BoxFit.cover)),
          child: Column(children: [
            const retour(),
            Column(
              children: [
                SizedBox(
                  height: height / 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Fruits_Anglais()));
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/img/fruits.png',
                        height: 100,
                        width: 100,
                      ),
                      Center(
                        child: AppText(
                          text: 'Fruits',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height / 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Legumes_Anglais()));
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/img/vegetables.png',
                        height: 100,
                        width: 100,
                      ),
                      Center(
                        child: AppText(
                          text: 'Legumes',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height / 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Animaux_Anglais()));
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/img/livestock.png',
                        height: 100,
                        width: 100,
                      ),
                      Center(
                        child: AppText(
                          text: 'Animaux',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
