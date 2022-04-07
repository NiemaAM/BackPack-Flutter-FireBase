import 'package:flutter/cupertino.dart';

// ignore: camel_case_types
class avatarChoix extends StatefulWidget {
  const avatarChoix({Key key}) : super(key: key);

  @override
  _avatarChoixState createState() => _avatarChoixState();
}

// ignore: camel_case_types
class _avatarChoixState extends State<avatarChoix> {
  List img = [
    "avatar_1.png",
    "avatar_2.png",
    "avatar_3.png",
    "avatar_4.png",
    "avatar_5.png",
    "avatar_6.png"
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: img.length,
        itemBuilder: (_, index) {
          return Column(
            children: [
              Container(
                  margin: const EdgeInsets.all(10),
                  width: width / 2,
                  height: width / 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                          image: AssetImage("./assets/img/" + img[index]),
                          fit: BoxFit.cover))),
            ],
          );
        });
  }
}
