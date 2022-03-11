import 'package:firstapp/widgets/menue_paratemtres.dart';
import 'package:firstapp/widgets/slide_jeux.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

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
    return Scaffold(body: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxHeight >= 600) {
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
              menue(),
              SizedBox(
                height: height / 5,
              ),
              Container(
                width: width,
                height: height / 2,
                child: slideJeux(),
              )
            ]),
          );
        } else {
          return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/img/Main_fond.png"),
                    fit: BoxFit.cover)),
            child: Column(children: [
              menue(),
              SizedBox(
                height: 5,
              ),
              Container(
                width: 400,
                height: 400,
                child: slideJeux(),
              )
            ]),
          );
        }
      },
    ));
  }
}

class music extends _acceilState {}
