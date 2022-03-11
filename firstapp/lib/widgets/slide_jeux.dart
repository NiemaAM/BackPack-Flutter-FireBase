import 'package:audioplayers/audioplayers.dart';
import 'package:firstapp/jeux/Draw.dart';
import 'package:firstapp/pages/page_choix_jeux_langues.dart';
import 'package:firstapp/pages/page_choix_jeux_maths.dart';
import 'package:firstapp/pages/page_choix_jeux_puzzles.dart';
import 'package:firstapp/pages/page_choix_jeux_quiz.dart';
import 'package:firstapp/pages/page_parametres.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class slideJeux extends StatefulWidget {
  const slideJeux({Key key}) : super(key: key);

  @override
  _slideJeuxState createState() => _slideJeuxState();
}

class _slideJeuxState extends State<slideJeux> {
  List img = [
    "./assets/img/Quiz_img.png",
    "./assets/img/Puzzles_img.png",
    "./assets/img/Langues_img.png",
    "./assets/img/Maths_img.png",
    "./assets/img/Dessin_img.png",
    "./assets/img/Livres_img.png",
    "./assets/img/Musique_img.png"
  ];
  List links = [
    pageQuizChoix(),
    pagePuzzleChoix(),
    pageLanguesChoix(),
    pageMathChoix(),
    Draw(),
    parametres(),
    parametres()
  ];

  AudioCache player = new AudioCache(fixedPlayer: AudioPlayer());
  @override
  Future<void> dispose() async {
    super.dispose(); //change here
    await player.fixedPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    player.loop("musiques_fond/HeatleyBros_main.mp3");
    player.fixedPlayer.setVolume(1.0);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return CarouselSlider.builder(
        itemCount: img.length,
        options: CarouselOptions(
          height: height / 2,
          autoPlay: true,
          enlargeCenterPage: true,
        ),
        itemBuilder: (context, index, realIndex) {
          final imgs = img[index];

          return buildImg(imgs, index);
        });
  }

  Widget buildImg(String img, int index) => GestureDetector(
      onTap: () {
        dispose();
        Navigator.of(context).push(PageRouteBuilder(
            transitionDuration: Duration(seconds: 1),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secanimation,
                Widget child) {
              animation = CurvedAnimation(
                  parent: animation, curve: Curves.elasticInOut);
              return ScaleTransition(
                  alignment: Alignment.center,
                  scale: animation,
                  child: links[index]);
            },
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secAnimation) {
              return links[index];
            }));
      },
      // Image tapped
      child: Image.asset(img, scale: 0.8));
}
