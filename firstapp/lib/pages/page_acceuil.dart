import 'package:firstapp/widgets/menue_paratemtres.dart';
import 'package:firstapp/widgets/slide_jeux.dart';
import 'package:flutter/material.dart';

import '../widgets/Audio_BK.dart';
import '../widgets/menue_infos.dart';

// ignore: camel_case_types
class acceil extends StatefulWidget {
  const acceil({Key key}) : super(key: key);

  @override
  _acceilState createState() => _acceilState();
}

// ignore: camel_case_types
class _acceilState extends State<acceil> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Audio_BK.loopBK();
    return Scaffold(body: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;
        return Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/img/Main_fond.png"),
                  fit: BoxFit.cover)),
          child: Column(children: [
            const menue(),
            SizedBox(
              height: height / 5,
            ),
            SizedBox(
              width: width,
              height: height / 2,
              child: const slideJeux(),
            ),
            Container(
              margin: const EdgeInsets.only(right: 10, top: 50),
              child: const menueInfos(),
            )
          ]),
        );
      },
    ));
  }
}
