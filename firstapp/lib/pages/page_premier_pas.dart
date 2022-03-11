/* import 'package:firstapp/widgets/app_text.dart';
import 'package:firstapp/widgets/champ_text.dart';
import 'package:firstapp/widgets/responsive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ignore: camel_case_types
class premier_pas extends StatefulWidget {
  const premier_pas({Key? key}) : super(key: key);

  @override
  _premier_pasState createState() => _premier_pasState();
}

// ignore: camel_case_types
class _premier_pasState extends State<premier_pas> {
  List img = ["page_parents.png", "page_kid.png"];
  List text = ["Espace de contrôle parental", "Espace du profil de l'enfant"];
  List text2 = ["Creér un mot de passe", "Ton nom"];
  List text3 = ["", "Ton avatar"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: img.length,
          itemBuilder: (_, index) {
            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("./assets/img/" + img[index]),
                      fit: BoxFit.cover)),
              child: Container(
                margin: const EdgeInsets.only(top: 70, left: 30, right: 5),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 350,
                          height: 420,
                          child: AppText(text: text[index]),
                        ),
                        Container(
                            width: 220,
                            height: 60,
                            child: AppText(
                              text: text2[index],
                              size: 30,
                            )),
                        Container(
                          width: 220,
                          height: 60,
                          child: champText(),
                        ),
                        Container(
                            width: 300,
                            height: 100,
                            child: Align(
                                alignment: Alignment.center,
                                child: ResponsiveButton(
                                    width: 120, text: "suivant")))
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
 */