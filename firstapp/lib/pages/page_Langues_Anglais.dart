// ignore_for_file: deprecated_member_use, file_names
import 'package:firstapp/jeux/Langues/Anglais/fruits.dart';
import 'package:firstapp/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../jeux/Langues/Anglais/animaux.dart';
import '../jeux/Langues/Anglais/legumes.dart';
import '../widgets/menue_retour.dart';

// ignore: camel_case_types
class Anglais extends StatefulWidget {
  const Anglais({Key key}) : super(key: key);

  @override
  _AnglaisState createState() => _AnglaisState();
}

// ignore: camel_case_types
class _AnglaisState extends State<Anglais> {
  var player = AudioCache();
  @override
  Widget build(BuildContext context) {
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
              Column(
                children: [
                  SizedBox(
                    height: height / 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      player.play('sfx/poop.mp3');
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
                      player.play('sfx/poop.mp3');
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
                            text: 'Vegetables',
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
                      player.play('sfx/poop.mp3');
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
                            text: 'Animals',
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
      ),
    );
  }
}
