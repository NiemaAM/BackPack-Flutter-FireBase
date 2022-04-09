import 'package:firstapp/widgets/app_text.dart';
import 'package:flutter/material.dart';

import '../../widgets/Audio.dart';
import '../../widgets/menue_retour.dart';

// ignore: camel_case_types
class livres extends StatefulWidget {
  const livres({Key key}) : super(key: key);

  @override
  State<livres> createState() => _livresState();
}

// ignore: camel_case_types
class _livresState extends State<livres> {
  List cantines = [
    "Livres_audio/Charles_Perrault_-_Le_petit_chaperon_rouge.mp3",
    "Livres_audio/Charles_Perrault_-_Le_petit_poucet.mp3",
    "Livres_audio/Hans_Christian_Andersen_-_La_petite_fille_aux_allumettes.mp3",
    "Livres_audio/Jeanne_-_Marie_Leprince_de_Beaumont_-_La_belle_et_la_bete.mp3"
  ];
  List titre = [
    "Le petit chaperon rouge",
    "Le petit poucet",
    "La petite fille aux allumettes",
    "La belle et la bete"
  ];
  String text = "Le petit chaperon rouge";
  bool isplaying = false;
  String music = "Livres_audio/Charles_Perrault_-_Le_petit_chaperon_rouge.mp3";
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
              Slider.adaptive(
                max: 100,
                min: 1,
                onChanged: (double value) {},
                value: 1,
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
              ]),
            ],
          ),
        );
      }),
    );
  }
}
