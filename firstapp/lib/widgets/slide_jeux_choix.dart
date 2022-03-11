import 'package:firstapp/widgets/responsive_button.dart';
import 'package:flutter/cupertino.dart';

import 'app_text.dart';

class slideChoix extends StatefulWidget {
  const slideChoix({Key key}) : super(key: key);

  @override
  _slideChoixState createState() => _slideChoixState();
}

class _slideChoixState extends State<slideChoix> {
  List img = [
    "jeu_1.png",
    "jeu_2.png",
    "jeu_3.png",
    "jeu_4.png",
    "jeu_1.png",
    "jeu_2.png"
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: img.length,
        itemBuilder: (_, index) {
          return Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(right: 15, top: 10),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: AssetImage("./assets/img/" + img[index]),
                          fit: BoxFit.cover))),
            ],
          );
        });
  }
}
