// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firstapp/jeux/Quiz/reponse.dart';
import 'package:firstapp/widgets/app_text.dart';
import 'package:firstapp/widgets/menue_retour.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/pop_up_quiz.dart';

// ignore: camel_case_types
class Quiz_Annimaux extends StatefulWidget {
  const Quiz_Annimaux({Key key}) : super(key: key);

  @override
  _Quiz_AnnimauxState createState() => _Quiz_AnnimauxState();
}

// ignore: camel_case_types
class _Quiz_AnnimauxState extends State<Quiz_Annimaux> {
  var player = AudioCache();
  List<Icon> _scoreTracker = [];
  int _questionIndex = 0;
  int _totalScore = 0;
  bool answerWasSelected = false;
  bool endOfQuiz = false;
  bool correctAnswerSelected = false;
  int random = 0;
  List<int> reponse = [];

  int isoppend = 3;
  String score = '0';
  // ignore: non_constant_identifier_names
  int score_int = 0;
  final referenceDatabase = FirebaseDatabase.instance;
  String deviceName = '';
  String deviceVersion = '';
  String identifier = '';

  Future<void> _deviceDetails() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        setState(() {
          deviceName = build.model;
          deviceVersion = build.version.toString();
          identifier = build.androidId;
        });
        //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        setState(() {
          deviceName = data.name;
          deviceVersion = data.systemVersion;
          identifier = data.identifierForVendor;
        }); //UUID for iOS
      }
    } on PlatformException {
      // ignore: avoid_print
      print('Failed to get platform version');
    }
  }

  getData() async {
    _deviceDetails();
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('$identifier/id').get();
    final snapshot4 = await ref.child('$identifier/Enfant/Score').get();
    if (snapshot.value == identifier) {
      setState(() {
        isoppend = 1;
        score = snapshot4.value;
      });
    } else {
      setState(() {
        isoppend = 0;
      });
    }
  }

  wait() async {
    await Future.delayed(const Duration(seconds: 1), () {});
    if (endOfQuiz == false) {
      _nextQuestion();
      randomInt();
    }
  }

  checkScore() {
    final ref = referenceDatabase.reference();
    if (endOfQuiz == true) {
      setState(() {
        getData();
        score_int = int.parse(score);
        score_int = score_int + _totalScore;
      });
      ref.update({
        "$identifier/Enfant/Score": '$score_int',
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const CustomDialogBox(
              text: "Retour",
              descriptions: "Ton score est maintenant :",
              title: "Bien jouer !",
            );
          });
    }
  }

  void _questionAnswered(bool answerScore) {
    setState(() {
      // answer was selected
      answerWasSelected = true;

      // check if answer was correct
      if (answerScore) {
        _totalScore++;
        player.play('sfx/ding.mp3');
        correctAnswerSelected = true;
      } else {
        player.play('sfx/didum.mp3');
      }
      // adding to the score tracker on top
      _scoreTracker.add(
        answerScore
            // ignore: prefer_const_constructors
            ? Icon(
                Icons.check_circle,
                color: Colors.green,
              )
            // ignore: prefer_const_constructors
            : Icon(
                Icons.clear,
                color: Colors.red,
              ),
      );
      //when the quiz ends
      if (_questionIndex + 1 == 10) {
        endOfQuiz = true;
      }
    });
  }

  void randomInt() {
    setState(() {
      var rng = Random();
      reponse.add(random);
      random = rng.nextInt(_questions.length);
      while (reponse.contains(random)) {
        random = rng.nextInt(_questions.length);
      }
    });
  }

  bool first = true;
  checkFirst() {
    if (first == true) {
      setState(() {
        random = Random().nextInt(_questions.length);
        first = false;
      });
    }
  }

  void _nextQuestion() {
    setState(() {
      _questionIndex++;
      answerWasSelected = false;
      correctAnswerSelected = false;
    });
    // what happens at the end of the quiz
    if (_questionIndex >= _questions.length) {
      _resetQuiz();
    }
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      _scoreTracker = [];
      endOfQuiz = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();
    checkFirst();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/img/page_parametres.png"),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                // ignore: sdk_version_ui_as_code
                if (height < 700)
                  const retour(
                    color: Colors.black,
                  ),
                // ignore: sdk_version_ui_as_code
                if (height > 700)
                  const retour(
                    color: Colors.white,
                  ),
                SizedBox(
                  height: height / 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          // ignore: unnecessary_string_interpolations
                          text: '${_totalScore.toString()}',
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              .copyWith(color: Colors.blue),
                        ),
                        TextSpan(
                          text: '/10',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: width - 10,
                  height: 250,
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                  child: Column(
                    children: [
                      Center(
                        child: AppText(
                          text: "Quel est cet animal ?",
                          size: 40,
                          color: Colors.black,
                        ),
                      ),
                      Expanded(child: Container()),
                      Image.asset(
                        _questions[random]['image1'],
                        height: 130,
                      ),
                    ],
                  ),
                ),
                // ignore: sdk_version_ui_as_code
                ...(_questions[random]['answers'] as List<Map<String, Object>>)
                    .map(
                  (answer) => Answer(
                    answerText: answer['answerText'],
                    answerColor: answerWasSelected
                        ? answer['score']
                            ? const Color.fromARGB(255, 103, 204, 106)
                            : const Color.fromARGB(255, 241, 91, 80)
                        : null,
                    answerTap: () {
                      // if answer was already selected then nothing happens onTap
                      if (answerWasSelected) {
                        return;
                      }
                      //answer is being selected
                      _questionAnswered(answer['score']);
                      checkScore();
                      wait();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

const _questions = [
  {
    'image1': 'assets/img/animaux/bird.png',
    'answers': [
      {'answerText': 'un Oiseau', 'score': true},
      {'answerText': 'un Canard', 'score': false},
      {'answerText': 'une Poule', 'score': false},
    ],
  },
  {
    'image1': 'assets/img/animaux/chicken.png',
    'answers': [
      {'answerText': 'un Coq', 'score': false},
      {'answerText': 'un Poussin', 'score': false},
      {'answerText': 'une Poule', 'score': true},
    ],
  },
  {
    'image1': 'assets/img/animaux/snake.png',
    'answers': [
      {'answerText': 'un Caméléon', 'score': false},
      {'answerText': 'un Manchot', 'score': false},
      {'answerText': 'un Serpent', 'score': true},
    ],
  },
  {
    'image1': 'assets/img/animaux/squirrel.png',
    'answers': [
      {'answerText': 'un Renard', 'score': false},
      {'answerText': 'un Écureuil', 'score': true},
      {'answerText': 'un Castor', 'score': false},
    ],
  },
  {
    'image1': 'assets/img/animaux/clown-fish.png',
    'answers': [
      {'answerText': 'un Poisson', 'score': true},
      {'answerText': 'un Dauphin', 'score': false},
      {'answerText': 'un Requin', 'score': false},
    ],
  },
  {
    'image1': 'assets/img/animaux/sheep.png',
    'answers': [
      {'answerText': 'un Mouton', 'score': true},
      {'answerText': 'un Chat', 'score': false},
      {'answerText': 'un Loup', 'score': false},
    ],
  },
  {
    'image1': 'assets/img/animaux/cow.png',
    'answers': [
      {'answerText': 'une Vache', 'score': true},
      {'answerText': 'un Cerf', 'score': false},
      {'answerText': 'un Chameau', 'score': false},
    ],
  },
  {
    'image1': 'assets/img/animaux/zebra.png',
    'answers': [
      {'answerText': 'un Chameau', 'score': false},
      {'answerText': 'un Cheval', 'score': false},
      {'answerText': 'un Zèbre', 'score': true},
    ],
  },
  {
    'image1': 'assets/img/animaux/mouse.png',
    'answers': [
      {'answerText': 'un Cochon d\'Inde', 'score': false},
      {'answerText': 'un Hamster', 'score': false},
      {'answerText': 'une Souris', 'score': true},
    ],
  },
  {
    'image1': 'assets/img/animaux/owl.png',
    'answers': [
      {'answerText': 'une Poule', 'score': false},
      {'answerText': 'un Perroquet', 'score': false},
      {'answerText': 'un Hibou', 'score': true},
    ],
  },
  {
    'image1': 'assets/img/animaux/camel.png',
    'answers': [
      {'answerText': 'un Cheval', 'score': false},
      {'answerText': 'un Cerf', 'score': false},
      {'answerText': 'un Chameau', 'score': true},
    ],
  },
  {
    'image1': 'assets/img/animaux/giraffe.png',
    'answers': [
      {'answerText': 'un Lion', 'score': false},
      {'answerText': 'une Girafe', 'score': true},
      {'answerText': 'un Éléphant', 'score': false},
    ],
  },
  {
    'image1': 'assets/img/animaux/lion.png',
    'answers': [
      {'answerText': 'un Lion', 'score': true},
      {'answerText': 'un Renard', 'score': false},
      {'answerText': 'un Loup', 'score': false},
    ],
  },
  {
    'image1': 'assets/img/animaux/beaver.png',
    'answers': [
      {'answerText': 'un Castor', 'score': true},
      {'answerText': 'un Hamster', 'score': false},
      {'answerText': 'un Écureuil', 'score': false},
    ],
  },
  {
    'image1': 'assets/img/animaux/chameleon.png',
    'answers': [
      {'answerText': 'un Coq', 'score': false},
      {'answerText': 'un Poussin', 'score': false},
      {'answerText': 'un Caméléon', 'score': true},
    ],
  },
  {
    'image1': 'assets/img/animaux/shark.png',
    'answers': [
      {'answerText': 'une Baleine', 'score': false},
      {'answerText': 'un Poisson', 'score': false},
      {'answerText': 'un Requin', 'score': true},
    ],
  },
  {
    'image1': 'assets/img/animaux/chick.png',
    'answers': [
      {'answerText': 'une Poule', 'score': false},
      {'answerText': 'un Poussin', 'score': true},
      {'answerText': 'un Coq', 'score': false},
    ],
  },
  {
    'image1': 'assets/img/animaux/crab.png',
    'answers': [
      {'answerText': 'un Crabe', 'score': true},
      {'answerText': 'un Poisson', 'score': false},
      {'answerText': 'un Requin', 'score': false},
    ],
  },
  {
    'image1': 'assets/img/animaux/deer.png',
    'answers': [
      {'answerText': 'un Cerf', 'score': true},
      {'answerText': 'un Chien', 'score': false},
      {'answerText': 'un Loup', 'score': false},
    ],
  },
  {
    'image1': 'assets/img/animaux/dog.png',
    'answers': [
      {'answerText': 'un Chien', 'score': true},
      {'answerText': 'un Loup', 'score': false},
      {'answerText': 'un Chat', 'score': false},
    ],
  },
  {
    'image1': 'assets/img/animaux/dolphin.png',
    'answers': [
      {'answerText': 'une Baleine', 'score': false},
      {'answerText': 'un Requin', 'score': false},
      {'answerText': 'un Dauphin', 'score': true},
    ],
  },
  {
    'image1': 'assets/img/animaux/duck.png',
    'answers': [
      {'answerText': 'une Poul', 'score': false},
      {'answerText': 'un Coq', 'score': false},
      {'answerText': 'un Canard', 'score': true},
    ],
  },
  {
    'image1': 'assets/img/animaux/elephant.png',
    'answers': [
      {'answerText': 'un Hamster', 'score': false},
      {'answerText': 'une Girafe', 'score': false},
      {'answerText': 'un Éléphant', 'score': true},
    ],
  },
  {
    'image1': 'assets/img/animaux/fox.png',
    'answers': [
      {'answerText': 'un Loup', 'score': false},
      {'answerText': 'un Chien', 'score': false},
      {'answerText': 'un Renard', 'score': true},
    ],
  },
  {
    'image1': 'assets/img/animaux/guinea-pig.png',
    'answers': [
      {'answerText': 'un Hamster', 'score': false},
      {'answerText': 'un Cochon d\'Inde', 'score': true},
      {'answerText': 'une souris', 'score': false},
    ],
  },
  {
    'image1': 'assets/img/animaux/hamster.png',
    'answers': [
      {'answerText': 'un Hamster', 'score': true},
      {'answerText': 'une souris', 'score': false},
      {'answerText': 'un Écureuil', 'score': false},
    ],
  },
  {
    'image1': 'assets/img/animaux/panda-bear.png',
    'answers': [
      {'answerText': 'un Mouton', 'score': false},
      {'answerText': 'un Cheval', 'score': false},
      {'answerText': 'un Panda', 'score': true},
    ],
  },
  {
    'image1': 'assets/img/animaux/parrot.png',
    'answers': [
      {'answerText': 'un Oiseau', 'score': false},
      {'answerText': 'un Coq', 'score': false},
      {'answerText': 'un Perroquet', 'score': true},
    ],
  },
  {
    'image1': 'assets/img/animaux/penguin.png',
    'answers': [
      {'answerText': 'une Poule', 'score': false},
      {'answerText': 'un Perroquet', 'score': false},
      {'answerText': 'un Manchot', 'score': true},
    ],
  },
  {
    'image1': 'assets/img/animaux/rooster.png',
    'answers': [
      {'answerText': 'un Oiseau', 'score': false},
      {'answerText': 'une Poule', 'score': false},
      {'answerText': 'un Coq', 'score': true},
    ],
  },
  {
    'image1': 'assets/img/animaux/turtle.png',
    'answers': [
      {'answerText': 'un Crabe', 'score': false},
      {'answerText': 'une Tortue', 'score': true},
      {'answerText': 'un Caméléon', 'score': false},
    ],
  },
  {
    'image1': 'assets/img/animaux/whale.png',
    'answers': [
      {'answerText': 'une Baleine', 'score': true},
      {'answerText': 'un Dauphin', 'score': false},
      {'answerText': 'un Requin', 'score': false},
    ],
  },
  {
    'image1': 'assets/img/animaux/wolf.png',
    'answers': [
      {'answerText': 'un Loup', 'score': true},
      {'answerText': 'un Chien', 'score': false},
      {'answerText': 'un Renard', 'score': false},
    ],
  },
];
