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
class Quiz_Maths extends StatefulWidget {
  const Quiz_Maths({Key key}) : super(key: key);

  @override
  _Quiz_MathsState createState() => _Quiz_MathsState();
}

// ignore: camel_case_types
class _Quiz_MathsState extends State<Quiz_Maths> {
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
                          text: _questions[random]['question'],
                          size: width / 9,
                          color: Colors.black,
                        ),
                      ),
                      Expanded(child: Container()),
                      Row(
                        children: [
                          Image.asset(
                            _questions[random]['image1'],
                            height: width / 3,
                          ),
                          Expanded(child: Container()),
                          AppText(
                            text: _questions[random]['signe'],
                            size: width / 5,
                            color: Colors.blue,
                          ),
                          Expanded(child: Container()),
                          Image.asset(
                            _questions[random]['image2'],
                            height: width / 3,
                          ),
                        ],
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
    'question': '1+1=',
    'image1': 'assets/img/1apples.png',
    'signe': '+',
    'image2': 'assets/img/1apples.png',
    'answers': [
      {'answerText': '2', 'score': true},
      {'answerText': '3', 'score': false},
      {'answerText': '6', 'score': false},
    ],
  },
  {
    'question': '1+2=',
    'image1': 'assets/img/1apples.png',
    'signe': '+',
    'image2': 'assets/img/2apples.png',
    'answers': [
      {'answerText': '6', 'score': false},
      {'answerText': '7', 'score': false},
      {'answerText': '3', 'score': true},
    ],
  },
  {
    'question': '1+3=',
    'image1': 'assets/img/1apples.png',
    'signe': '+',
    'image2': 'assets/img/3apples.png',
    'answers': [
      {'answerText': '5', 'score': false},
      {'answerText': '7', 'score': false},
      {'answerText': '4', 'score': true},
    ],
  },
  {
    'question': '1+4=',
    'image1': 'assets/img/1apples.png',
    'signe': '+',
    'image2': 'assets/img/4apples.png',
    'answers': [
      {'answerText': '6', 'score': false},
      {'answerText': '5', 'score': true},
      {'answerText': '9', 'score': false},
    ],
  },
  {
    'question': '1+5=',
    'image1': 'assets/img/1apples.png',
    'signe': '+',
    'image2': 'assets/img/5apples.png',
    'answers': [
      {'answerText': '7', 'score': false},
      {'answerText': '6', 'score': true},
      {'answerText': '9', 'score': false},
    ],
  },
  {
    'question': '2+1=',
    'image1': 'assets/img/2apples.png',
    'signe': '+',
    'image2': 'assets/img/1apples.png',
    'answers': [
      {'answerText': '3', 'score': true},
      {'answerText': '2', 'score': false},
      {'answerText': '6', 'score': false},
    ],
  },
  {
    'question': '2+2=',
    'image1': 'assets/img/2apples.png',
    'signe': '+',
    'image2': 'assets/img/2apples.png',
    'answers': [
      {'answerText': '6', 'score': false},
      {'answerText': '7', 'score': false},
      {'answerText': '4', 'score': true},
    ],
  },
  {
    'question': '2+3=',
    'image1': 'assets/img/2apples.png',
    'signe': '+',
    'image2': 'assets/img/3apples.png',
    'answers': [
      {'answerText': '4', 'score': false},
      {'answerText': '7', 'score': false},
      {'answerText': '5', 'score': true},
    ],
  },
  {
    'question': '2+4=',
    'image1': 'assets/img/2apples.png',
    'signe': '+',
    'image2': 'assets/img/4apples.png',
    'answers': [
      {'answerText': '5', 'score': false},
      {'answerText': '6', 'score': true},
      {'answerText': '9', 'score': false},
    ],
  },
  {
    'question': '2+5=',
    'image1': 'assets/img/2apples.png',
    'signe': '+',
    'image2': 'assets/img/5apples.png',
    'answers': [
      {'answerText': '6', 'score': false},
      {'answerText': '7', 'score': true},
      {'answerText': '8', 'score': false},
    ],
  },
  {
    'question': '3+1=',
    'image1': 'assets/img/3apples.png',
    'signe': '+',
    'image2': 'assets/img/1apples.png',
    'answers': [
      {'answerText': '4', 'score': true},
      {'answerText': '3', 'score': false},
      {'answerText': '6', 'score': false},
    ],
  },
  {
    'question': '3+2=',
    'image1': 'assets/img/3apples.png',
    'signe': '+',
    'image2': 'assets/img/2apples.png',
    'answers': [
      {'answerText': '6', 'score': false},
      {'answerText': '7', 'score': false},
      {'answerText': '5', 'score': true},
    ],
  },
  {
    'question': '3+3=',
    'image1': 'assets/img/3apples.png',
    'signe': '+',
    'image2': 'assets/img/3apples.png',
    'answers': [
      {'answerText': '9', 'score': false},
      {'answerText': '7', 'score': false},
      {'answerText': '6', 'score': true},
    ],
  },
  {
    'question': '3+4=',
    'image1': 'assets/img/3apples.png',
    'signe': '+',
    'image2': 'assets/img/4apples.png',
    'answers': [
      {'answerText': '6', 'score': false},
      {'answerText': '7', 'score': true},
      {'answerText': '9', 'score': false},
    ],
  },
  {
    'question': '3+5=',
    'image1': 'assets/img/3apples.png',
    'signe': '+',
    'image2': 'assets/img/5apples.png',
    'answers': [
      {'answerText': '7', 'score': false},
      {'answerText': '8', 'score': true},
      {'answerText': '9', 'score': false},
    ],
  },
  {
    'question': '4+1=',
    'image1': 'assets/img/4apples.png',
    'signe': '+',
    'image2': 'assets/img/1apples.png',
    'answers': [
      {'answerText': '5', 'score': true},
      {'answerText': '3', 'score': false},
      {'answerText': '6', 'score': false},
    ],
  },
  {
    'question': '4+2=',
    'image1': 'assets/img/4apples.png',
    'signe': '+',
    'image2': 'assets/img/2apples.png',
    'answers': [
      {'answerText': '8', 'score': false},
      {'answerText': '7', 'score': false},
      {'answerText': '6', 'score': true},
    ],
  },
  {
    'question': '4+3=',
    'image1': 'assets/img/4apples.png',
    'signe': '+',
    'image2': 'assets/img/3apples.png',
    'answers': [
      {'answerText': '12', 'score': false},
      {'answerText': '8', 'score': false},
      {'answerText': '7', 'score': true},
    ],
  },
  {
    'question': '4+4=',
    'image1': 'assets/img/4apples.png',
    'signe': '+',
    'image2': 'assets/img/4apples.png',
    'answers': [
      {'answerText': '6', 'score': false},
      {'answerText': '8', 'score': true},
      {'answerText': '9', 'score': false},
    ],
  },
  {
    'question': '4+5=',
    'image1': 'assets/img/4apples.png',
    'signe': '+',
    'image2': 'assets/img/4apples.png',
    'answers': [
      {'answerText': '7', 'score': false},
      {'answerText': '8', 'score': true},
      {'answerText': '9', 'score': false},
    ],
  },
  {
    'question': '5+1=',
    'image1': 'assets/img/5apples.png',
    'signe': '+',
    'image2': 'assets/img/1apples.png',
    'answers': [
      {'answerText': '6', 'score': true},
      {'answerText': '7', 'score': false},
      {'answerText': '5', 'score': false},
    ],
  },
  {
    'question': '5+2=',
    'image1': 'assets/img/5apples.png',
    'signe': '+',
    'image2': 'assets/img/2apples.png',
    'answers': [
      {'answerText': '6', 'score': false},
      {'answerText': '10', 'score': false},
      {'answerText': '7', 'score': true},
    ],
  },
  {
    'question': '5+3=',
    'image1': 'assets/img/5apples.png',
    'signe': '+',
    'image2': 'assets/img/3apples.png',
    'answers': [
      {'answerText': '4', 'score': false},
      {'answerText': '7', 'score': false},
      {'answerText': '8', 'score': true},
    ],
  },
  {
    'question': '5+4=',
    'image1': 'assets/img/5apples.png',
    'signe': '+',
    'image2': 'assets/img/4apples.png',
    'answers': [
      {'answerText': '6', 'score': false},
      {'answerText': '9', 'score': true},
      {'answerText': '8', 'score': false},
    ],
  },
  {
    'question': '5+5=',
    'image1': 'assets/img/5apples.png',
    'signe': '+',
    'image2': 'assets/img/5apples.png',
    'answers': [
      {'answerText': '7', 'score': false},
      {'answerText': '10', 'score': true},
      {'answerText': '9', 'score': false},
    ],
  },
  {
    'question': '3-1=',
    'image1': 'assets/img/3bananas.png',
    'signe': '-',
    'image2': 'assets/img/1bananas.png',
    'answers': [
      {'answerText': '2', 'score': true},
      {'answerText': '4', 'score': false},
      {'answerText': '3', 'score': false},
    ],
  },
  {
    'question': '5-1=',
    'image1': 'assets/img/5bananas.png',
    'signe': '-',
    'image2': 'assets/img/1bananas.png',
    'answers': [
      {'answerText': '4', 'score': true},
      {'answerText': '1', 'score': false},
      {'answerText': '3', 'score': false},
    ],
  },
  {
    'question': '5-2=',
    'image1': 'assets/img/5bananas.png',
    'signe': '-',
    'image2': 'assets/img/2bananas.png',
    'answers': [
      {'answerText': '3', 'score': true},
      {'answerText': '2', 'score': false},
      {'answerText': '7', 'score': false},
    ],
  },
  {
    'question': '5-3=',
    'image1': 'assets/img/5bananas.png',
    'signe': '-',
    'image2': 'assets/img/3bananas.png',
    'answers': [
      {'answerText': '7', 'score': false},
      {'answerText': '1', 'score': false},
      {'answerText': '2', 'score': true},
    ],
  },
  {
    'question': '5-4=',
    'image1': 'assets/img/5bananas.png',
    'signe': '-',
    'image2': 'assets/img/4bananas.png',
    'answers': [
      {'answerText': '3', 'score': false},
      {'answerText': '0', 'score': false},
      {'answerText': '1', 'score': true},
    ],
  },
  {
    'question': '5-5=',
    'image1': 'assets/img/5bananas.png',
    'signe': '-',
    'image2': 'assets/img/5bananas.png',
    'answers': [
      {'answerText': '1', 'score': false},
      {'answerText': '6', 'score': false},
      {'answerText': '0', 'score': true},
    ],
  },
  {
    'question': '4-1=',
    'image1': 'assets/img/4bananas.png',
    'signe': '-',
    'image2': 'assets/img/1bananas.png',
    'answers': [
      {'answerText': '3', 'score': true},
      {'answerText': '1', 'score': false},
      {'answerText': '4', 'score': false},
    ],
  },
  {
    'question': '4-2=',
    'image1': 'assets/img/4bananas.png',
    'signe': '-',
    'image2': 'assets/img/2bananas.png',
    'answers': [
      {'answerText': '2', 'score': true},
      {'answerText': '3', 'score': false},
      {'answerText': '7', 'score': false},
    ],
  },
  {
    'question': '4-3=',
    'image1': 'assets/img/4bananas.png',
    'signe': '-',
    'image2': 'assets/img/3bananas.png',
    'answers': [
      {'answerText': '7', 'score': false},
      {'answerText': '2', 'score': false},
      {'answerText': '1', 'score': true},
    ],
  },
  {
    'question': '4-4=',
    'image1': 'assets/img/4bananas.png',
    'signe': '-',
    'image2': 'assets/img/4bananas.png',
    'answers': [
      {'answerText': '3', 'score': false},
      {'answerText': '1', 'score': false},
      {'answerText': '0', 'score': true},
    ],
  },
  {
    'question': '3-1=',
    'image1': 'assets/img/3bananas.png',
    'signe': '-',
    'image2': 'assets/img/1bananas.png',
    'answers': [
      {'answerText': '2', 'score': true},
      {'answerText': '1', 'score': false},
      {'answerText': '3', 'score': false},
    ],
  },
  {
    'question': '3-2=',
    'image1': 'assets/img/3bananas.png',
    'signe': '-',
    'image2': 'assets/img/2bananas.png',
    'answers': [
      {'answerText': '1', 'score': true},
      {'answerText': '2', 'score': false},
      {'answerText': '7', 'score': false},
    ],
  },
  {
    'question': '3-3=',
    'image1': 'assets/img/3bananas.png',
    'signe': '-',
    'image2': 'assets/img/3bananas.png',
    'answers': [
      {'answerText': '9', 'score': false},
      {'answerText': '6', 'score': false},
      {'answerText': '0', 'score': true},
    ],
  },
  {
    'question': '2-1=',
    'image1': 'assets/img/2bananas.png',
    'signe': '-',
    'image2': 'assets/img/1bananas.png',
    'answers': [
      {'answerText': '3', 'score': false},
      {'answerText': '0', 'score': false},
      {'answerText': '1', 'score': true},
    ],
  },
  {
    'question': '2-2=',
    'image1': 'assets/img/2bananas.png',
    'signe': '-',
    'image2': 'assets/img/2bananas.png',
    'answers': [
      {'answerText': '1', 'score': false},
      {'answerText': '4', 'score': false},
      {'answerText': '0', 'score': true},
    ],
  },
  {
    'question': '1-1=',
    'image1': 'assets/img/1bananas.png',
    'signe': '-',
    'image2': 'assets/img/1bananas.png',
    'answers': [
      {'answerText': '1', 'score': false},
      {'answerText': '2', 'score': false},
      {'answerText': '0', 'score': true},
    ],
  },
  {
    'question': '1x0=',
    'image1': 'assets/img/1oranges.png',
    'signe': 'x',
    'image2': 'assets/img/0.png',
    'answers': [
      {'answerText': '0', 'score': true},
      {'answerText': '3', 'score': false},
      {'answerText': '1', 'score': false},
    ],
  },
  {
    'question': '1x1=',
    'image1': 'assets/img/1oranges.png',
    'signe': 'x',
    'image2': 'assets/img/1.png',
    'answers': [
      {'answerText': '2', 'score': false},
      {'answerText': '1', 'score': true},
      {'answerText': '4', 'score': false},
    ],
  },
  {
    'question': '1x2=',
    'image1': 'assets/img/1oranges.png',
    'signe': 'x',
    'image2': 'assets/img/2.png',
    'answers': [
      {'answerText': '3', 'score': false},
      {'answerText': '4', 'score': false},
      {'answerText': '2', 'score': true},
    ],
  },
  {
    'question': '1x3=',
    'image1': 'assets/img/1oranges.png',
    'signe': 'x',
    'image2': 'assets/img/3.png',
    'answers': [
      {'answerText': '4', 'score': false},
      {'answerText': '6', 'score': false},
      {'answerText': '3', 'score': true},
    ],
  },
  {
    'question': '1x4=',
    'image1': 'assets/img/1oranges.png',
    'signe': 'x',
    'image2': 'assets/img/4.png',
    'answers': [
      {'answerText': '6', 'score': false},
      {'answerText': '4', 'score': true},
      {'answerText': '5', 'score': false},
    ],
  },
  {
    'question': '1x5=',
    'image1': 'assets/img/1oranges.png',
    'signe': 'x',
    'image2': 'assets/img/5.png',
    'answers': [
      {'answerText': '6', 'score': false},
      {'answerText': '5', 'score': true},
      {'answerText': '7', 'score': false},
    ],
  },
  {
    'question': '2x0=',
    'image1': 'assets/img/2oranges.png',
    'signe': 'x',
    'image2': 'assets/img/0.png',
    'answers': [
      {'answerText': '0', 'score': true},
      {'answerText': '4', 'score': false},
      {'answerText': '2', 'score': false},
    ],
  },
  {
    'question': '2x1=',
    'image1': 'assets/img/2oranges.png',
    'signe': 'x',
    'image2': 'assets/img/1.png',
    'answers': [
      {'answerText': '3', 'score': false},
      {'answerText': '2', 'score': true},
      {'answerText': '4', 'score': false},
    ],
  },
  {
    'question': '2x2=',
    'image1': 'assets/img/2oranges.png',
    'signe': 'x',
    'image2': 'assets/img/2.png',
    'answers': [
      {'answerText': '3', 'score': false},
      {'answerText': '6', 'score': false},
      {'answerText': '4', 'score': true},
    ],
  },
  {
    'question': '2x3=',
    'image1': 'assets/img/2oranges.png',
    'signe': 'x',
    'image2': 'assets/img/3.png',
    'answers': [
      {'answerText': '4', 'score': false},
      {'answerText': '5', 'score': false},
      {'answerText': '6', 'score': true},
    ],
  },
  {
    'question': '2x4=',
    'image1': 'assets/img/2oranges.png',
    'signe': 'x',
    'image2': 'assets/img/4.png',
    'answers': [
      {'answerText': '6', 'score': false},
      {'answerText': '8', 'score': true},
      {'answerText': '12', 'score': false},
    ],
  },
  {
    'question': '2x5=',
    'image1': 'assets/img/2oranges.png',
    'signe': 'x',
    'image2': 'assets/img/5.png',
    'answers': [
      {'answerText': '15', 'score': false},
      {'answerText': '10', 'score': true},
      {'answerText': '7', 'score': false},
    ],
  },
  {
    'question': '3x0=',
    'image1': 'assets/img/3oranges.png',
    'signe': 'x',
    'image2': 'assets/img/0.png',
    'answers': [
      {'answerText': '0', 'score': true},
      {'answerText': '3', 'score': false},
      {'answerText': '6', 'score': false},
    ],
  },
  {
    'question': '3x1=',
    'image1': 'assets/img/3oranges.png',
    'signe': 'x',
    'image2': 'assets/img/1.png',
    'answers': [
      {'answerText': '6', 'score': false},
      {'answerText': '3', 'score': true},
      {'answerText': '4', 'score': false},
    ],
  },
  {
    'question': '3x2=',
    'image1': 'assets/img/3oranges.png',
    'signe': 'x',
    'image2': 'assets/img/2.png',
    'answers': [
      {'answerText': '3', 'score': false},
      {'answerText': '4', 'score': false},
      {'answerText': '6', 'score': true},
    ],
  },
  {
    'question': '3x3=',
    'image1': 'assets/img/3oranges.png',
    'signe': 'x',
    'image2': 'assets/img/3.png',
    'answers': [
      {'answerText': '4', 'score': false},
      {'answerText': '6', 'score': false},
      {'answerText': '9', 'score': true},
    ],
  },
  {
    'question': '3x4=',
    'image1': 'assets/img/3oranges.png',
    'signe': 'x',
    'image2': 'assets/img/4.png',
    'answers': [
      {'answerText': '6', 'score': false},
      {'answerText': '12', 'score': true},
      {'answerText': '16', 'score': false},
    ],
  },
  {
    'question': '3x5=',
    'image1': 'assets/img/3oranges.png',
    'signe': 'x',
    'image2': 'assets/img/5.png',
    'answers': [
      {'answerText': '14', 'score': false},
      {'answerText': '15', 'score': true},
      {'answerText': '20', 'score': false},
    ],
  },
  {
    'question': '4x0=',
    'image1': 'assets/img/4oranges.png',
    'signe': 'x',
    'image2': 'assets/img/0.png',
    'answers': [
      {'answerText': '0', 'score': true},
      {'answerText': '4', 'score': false},
      {'answerText': '8', 'score': false},
    ],
  },
  {
    'question': '4x1=',
    'image1': 'assets/img/4oranges.png',
    'signe': 'x',
    'image2': 'assets/img/1.png',
    'answers': [
      {'answerText': '8', 'score': false},
      {'answerText': '4', 'score': true},
      {'answerText': '5', 'score': false},
    ],
  },
  {
    'question': '4x2=',
    'image1': 'assets/img/4oranges.png',
    'signe': 'x',
    'image2': 'assets/img/2.png',
    'answers': [
      {'answerText': '4', 'score': false},
      {'answerText': '6', 'score': false},
      {'answerText': '8', 'score': true},
    ],
  },
  {
    'question': '4x3=',
    'image1': 'assets/img/4oranges.png',
    'signe': 'x',
    'image2': 'assets/img/3.png',
    'answers': [
      {'answerText': '16', 'score': false},
      {'answerText': '10', 'score': false},
      {'answerText': '12', 'score': true},
    ],
  },
  {
    'question': '4x4=',
    'image1': 'assets/img/4oranges.png',
    'signe': 'x',
    'image2': 'assets/img/4.png',
    'answers': [
      {'answerText': '18', 'score': false},
      {'answerText': '16', 'score': true},
      {'answerText': '12', 'score': false},
    ],
  },
  {
    'question': '4x5=',
    'image1': 'assets/img/4oranges.png',
    'signe': 'x',
    'image2': 'assets/img/5.png',
    'answers': [
      {'answerText': '15', 'score': false},
      {'answerText': '20', 'score': true},
      {'answerText': '25', 'score': false},
    ],
  },
  {
    'question': '5x0=',
    'image1': 'assets/img/5oranges.png',
    'signe': 'x',
    'image2': 'assets/img/0.png',
    'answers': [
      {'answerText': '0', 'score': true},
      {'answerText': '5', 'score': false},
      {'answerText': '10', 'score': false},
    ],
  },
  {
    'question': '5x1=',
    'image1': 'assets/img/5oranges.png',
    'signe': 'x',
    'image2': 'assets/img/1.png',
    'answers': [
      {'answerText': '6', 'score': false},
      {'answerText': '5', 'score': true},
      {'answerText': '4', 'score': false},
    ],
  },
  {
    'question': '5x2=',
    'image1': 'assets/img/5oranges.png',
    'signe': 'x',
    'image2': 'assets/img/2.png',
    'answers': [
      {'answerText': '7', 'score': false},
      {'answerText': '15', 'score': false},
      {'answerText': '10', 'score': true},
    ],
  },
  {
    'question': '5x3=',
    'image1': 'assets/img/5oranges.png',
    'signe': 'x',
    'image2': 'assets/img/3.png',
    'answers': [
      {'answerText': '12', 'score': false},
      {'answerText': '20', 'score': false},
      {'answerText': '15', 'score': true},
    ],
  },
  {
    'question': '5x4=',
    'image1': 'assets/img/5oranges.png',
    'signe': 'x',
    'image2': 'assets/img/4.png',
    'answers': [
      {'answerText': '15', 'score': false},
      {'answerText': '20', 'score': true},
      {'answerText': '25', 'score': false},
    ],
  },
  {
    'question': '5x5=',
    'image1': 'assets/img/5oranges.png',
    'signe': 'x',
    'image2': 'assets/img/5.png',
    'answers': [
      {'answerText': '30', 'score': false},
      {'answerText': '25', 'score': true},
      {'answerText': '20', 'score': false},
    ],
  },
];
