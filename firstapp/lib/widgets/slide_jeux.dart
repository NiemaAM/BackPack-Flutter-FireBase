import 'package:firstapp/jeux/Draw.dart';
import 'package:firstapp/pages/page_choix_jeux_langues.dart';
import 'package:firstapp/pages/page_choix_jeux_puzzles.dart';
import 'package:firstapp/pages/page_choix_jeux_quiz.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

// ignore: camel_case_types
class slideJeux extends StatefulWidget {
  const slideJeux({Key key}) : super(key: key);

  @override
  _slideJeuxState createState() => _slideJeuxState();
}

// ignore: camel_case_types
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
    const pageQuizChoix(),
    const pagePuzzleChoix(),
    const pageLanguesChoix(),
    const pageLanguesChoix(),
    const Draw(),
    const pageLanguesChoix(),
    const pageLanguesChoix()
  ];

  @override
  Widget build(BuildContext context) {
    double height = 400;
    return CarouselSlider.builder(
        itemCount: img.length,
        options: CarouselOptions(
          height: height,
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
        Navigator.of(context).push(PageRouteBuilder(
            transitionDuration: const Duration(seconds: 1),
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
