import 'package:firstapp/widgets/app_text.dart';
import 'package:flutter/material.dart';

import '../../widgets/Audio.dart';
import '../../widgets/menue_retour.dart';

// ignore: camel_case_types
class cantines extends StatefulWidget {
  const cantines({Key key}) : super(key: key);

  @override
  State<cantines> createState() => _cantinesState();
}

// ignore: camel_case_types
class _cantinesState extends State<cantines> {
  List cantines = [
    "musiques_fond/HeatleyBros_main.mp3",
    "musiques_fond/music2_fiver_milo.mp3",
    "musiques_fond/HeatleyBros_main.mp3"
  ];
  List titre = ["titre1", "titre2", "titre3"];
  String text = "titre1";
  bool isplaying = false;
  String music = "musiques_fond/HeatleyBros_main.mp3";
  int num = 0;
  bool apres = true;
  bool avant = false;
  getsons() async {
    if (isplaying == false) {
      Audio.pause();
    }
    if (isplaying == true) {
      Audio.play(music);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getsons();
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;
        return SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Image.asset("assets/img/haut.png"),
                Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: const retour(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: height / 5,
                    ),
                    Container(
                        margin: const EdgeInsets.all(10),
                        width: width / 1.5,
                        height: width / 1.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: const DecorationImage(
                                image: AssetImage("./assets/img/avatar_1.png"),
                                fit: BoxFit.cover))),
                    Center(
                      child: AppText(
                        // ignore: unnecessary_string_interpolations
                        text: "$text",
                        size: width / 10,
                        color: Colors.blue,
                      ),
                    ),
                    /* Slider.adaptive(
                      max: 100,
                      min: 1,
                      onChanged: (double value) {},
                      value: 1,
                    ), */
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: (avant)
                                ? Icon(
                                    Icons.arrow_back,
                                    color: Colors.black,
                                    size: width / 10,
                                  )
                                : Icon(
                                    Icons.arrow_back,
                                    color: Colors.grey,
                                    size: width / 10,
                                  ),
                            onPressed: () {
                              setState(() {
                                apres = true;
                                if (num == 0) {
                                } else if ((num - 1) == 0) {
                                  avant = false;
                                  num = 0;
                                  music = cantines[0];
                                  text = titre[0];
                                } else {
                                  num = num - 1;
                                  music = cantines[num];
                                  text = titre[num];
                                }
                              });
                            },
                          ),
                          SizedBox(
                            width: width / 10,
                          ),
                          IconButton(
                            icon: (isplaying)
                                ? Icon(
                                    Icons.pause,
                                    color: Colors.black,
                                    size: width / 10,
                                  )
                                : Icon(
                                    Icons.play_arrow,
                                    color: Colors.black,
                                    size: width / 10,
                                  ),
                            onPressed: () {
                              setState(() {
                                isplaying = !isplaying;
                              });
                            },
                          ),
                          SizedBox(
                            width: width / 10,
                          ),
                          IconButton(
                            icon: (apres)
                                ? Icon(
                                    Icons.arrow_forward,
                                    color: Colors.black,
                                    size: width / 10,
                                  )
                                : Icon(
                                    Icons.arrow_forward,
                                    color: Colors.grey,
                                    size: width / 10,
                                  ),
                            onPressed: () {
                              setState(() {
                                avant = true;
                                if (num == (cantines.length - 1)) {
                                } else if ((num + 2) == cantines.length) {
                                  apres = false;
                                  num = cantines.length - 1;
                                  music = cantines[num];
                                  text = titre[num];
                                } else {
                                  num = num + 1;
                                  music = cantines[num];
                                  text = titre[num];
                                }
                              });
                            },
                          ),
                        ]),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
