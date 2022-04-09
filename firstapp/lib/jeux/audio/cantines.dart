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
        return Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/img/page_parametres.png"),
                  fit: BoxFit.cover)),
          child: Column(
            children: <Widget>[
              const retour(),
              SizedBox(
                height: width / 3,
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
                  color: Colors.blue,
                ),
              ),
              Row(children: [
                const SizedBox(
                  width: 40,
                ),
                IconButton(
                  icon: (avant)
                      ? const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 50,
                        )
                      : const Icon(
                          Icons.arrow_back,
                          color: Colors.grey,
                          size: 50,
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
                Expanded(child: Container()),
                IconButton(
                  icon: (isplaying)
                      ? const Icon(
                          Icons.pause,
                          color: Colors.black,
                          size: 50,
                        )
                      : const Icon(
                          Icons.play_arrow,
                          color: Colors.black,
                          size: 50,
                        ),
                  onPressed: () {
                    setState(() {
                      isplaying = !isplaying;
                    });
                  },
                ),
                Expanded(child: Container()),
                IconButton(
                  icon: (apres)
                      ? const Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                          size: 50,
                        )
                      : const Icon(
                          Icons.arrow_forward,
                          color: Colors.grey,
                          size: 50,
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
                const SizedBox(
                  width: 40,
                ),
              ])
            ],
          ),
        );
      }),
    );
  }
}
