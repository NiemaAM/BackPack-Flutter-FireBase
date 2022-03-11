import 'dart:math';

import 'package:firstapp/jeux/Quiz/reponse.dart';
import 'package:firstapp/widgets/app_text.dart';
import 'package:firstapp/widgets/menue_retour.dart';
import 'package:flutter/material.dart';

class QuizAddition extends StatefulWidget {
  @override
  _QuizAdditionState createState() => _QuizAdditionState();
}

class _QuizAdditionState extends State<QuizAddition> {
  List<Icon> _scoreTracker = [];
  int _questionIndex = 0;
  int _totalScore = 0;
  bool answerWasSelected = false;
  bool endOfQuiz = false;
  bool correctAnswerSelected = false;
  int random = 0;
  List<int> reponse = [];

  void _questionAnswered(bool answerScore) {
    setState(() {
      // answer was selected
      answerWasSelected = true;
      // check if answer was correct
      if (answerScore) {
        _totalScore++;
        correctAnswerSelected = true;
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
      if (_questionIndex + 1 == _questions.length) {
        endOfQuiz = true;
      }
    });
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

  int randomInt() {
    setState(() {
      var rng = Random();
      reponse.add(random);
      random = rng.nextInt(_questions.length);
      while (reponse.contains(random)) {
        random = rng.nextInt(_questions.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/img/page_jeux_choix.png"),
              fit: BoxFit.cover)),
      child: Center(
        child: Column(
          children: [
            retour(),
            SizedBox(
              height: width / 9,
            ),
            // ignore: sdk_version_ui_as_code
            if (!endOfQuiz)
              SizedBox(
                height: height / 25,
                width: width,
              ),
            if (endOfQuiz)
              Container(
                height: height / 25,
                width: double.infinity,
                color: Colors.transparent,
                child: Center(
                  child: AppText(
                    text: 'Ton score final est :',
                    size: 25,
                  ),
                ),
              ),
            Container(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
              child: AppText(
                text: '${_totalScore.toString()}/${_questions.length}',
                size: 25,
              ),
            ),
            // ignore: sdk_version_ui_as_code
            Container(
              width: width,
              height: height / 5,
              margin:
                  const EdgeInsets.only(bottom: 10.0, left: 30.0, right: 30.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: AppText(
                  text: _questions[random]['question'],
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ),
            // ignore: sdk_version_ui_as_code
            ...(_questions[random]['answers'] as List<Map<String, Object>>).map(
              (answer) => Answer(
                answerText: answer['answerText'],
                answerColor: answerWasSelected
                    ? answer['score']
                        ? Colors.green[100]
                        : Colors.red[200]
                    : null,
                answerTap: () {
                  // if answer was already selected then nothing happens onTap
                  if (answerWasSelected) {
                    return;
                  }
                  //answer is being selected
                  _questionAnswered(answer['score']);
                },
              ),
            ),
            SizedBox(height: 20.0),
            if (!endOfQuiz)
              Container(
                  width: width / 3,
                  height: width / 7,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40.0),
                    ),
                    onPressed: () {
                      if (!answerWasSelected) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: AppText(
                            text:
                                'Selectionne une reponse avant de passer à la prochaine question',
                            size: 15,
                            color: Colors.white,
                          ),
                        ));
                        return;
                      }
                      _nextQuestion();
                      randomInt();
                    },
                    child: AppText(
                      text: endOfQuiz ? 'Rejouer' : 'Question suivante',
                      size: 20,
                      color: Colors.white,
                    ),
                  )),
          ],
        ),
      ),
    ));
  }
}

final _questions = const [
  {
    'question': '2+2',
    'answers': [
      {'answerText': '5', 'score': false},
      {'answerText': '4', 'score': true},
      {'answerText': '3', 'score': false},
      {'answerText': '2', 'score': false},
    ],
  },
  {
    'question': '3+5',
    'answers': [
      {'answerText': '6', 'score': false},
      {'answerText': '5', 'score': false},
      {'answerText': '8', 'score': true},
      {'answerText': '4', 'score': false},
    ],
  },
  {
    'question': '10+12',
    'answers': [
      {'answerText': '10', 'score': false},
      {'answerText': '20', 'score': false},
      {'answerText': '102', 'score': false},
      {'answerText': '22', 'score': true},
    ],
  },
  {
    'question': '8+8+1',
    'answers': [
      {'answerText': '15', 'score': false},
      {'answerText': '17', 'score': true},
      {'answerText': '20', 'score': false},
      {'answerText': '9', 'score': false},
    ],
  },
  {
    'question': '6+3+1',
    'answers': [
      {'answerText': '9', 'score': false},
      {'answerText': '12', 'score': false},
      {'answerText': '10', 'score': true},
      {'answerText': '4', 'score': false},
    ],
  },
  {
    'question': '3+7+7+2',
    'answers': [
      {'answerText': '13', 'score': false},
      {'answerText': '19', 'score': true},
      {'answerText': '30', 'score': false},
      {'answerText': '20', 'score': false},
    ],
  },
  {
    'question': '10+20+30+1',
    'answers': [
      {'answerText': '31', 'score': false},
      {'answerText': '40', 'score': false},
      {'answerText': '2', 'score': false},
      {'answerText': '61', 'score': true},
    ],
  },
  {
    'question': '9+9+2',
    'answers': [
      {'answerText': '20', 'score': true},
      {'answerText': '30', 'score': false},
      {'answerText': '34', 'score': false},
      {'answerText': '33', 'score': false},
    ],
  },
  {
    'question': '34+2',
    'answers': [
      {'answerText': '50', 'score': false},
      {'answerText': '39', 'score': false},
      {'answerText': '38', 'score': false},
      {'answerText': '36', 'score': true},
    ],
  },
  {
    'question': '34+20',
    'answers': [
      {'answerText': '50', 'score': false},
      {'answerText': '60', 'score': false},
      {'answerText': '54', 'score': true},
      {'answerText': '44', 'score': false},
    ],
  },
  {
    'question': '5+8',
    'answers': [
      {'answerText': '14', 'score': false},
      {'answerText': '13', 'score': true},
      {'answerText': '15', 'score': false},
      {'answerText': '17', 'score': false},
    ],
  },
  {
    'question': '7+63',
    'answers': [
      {'answerText': '70', 'score': true},
      {'answerText': '80', 'score': false},
      {'answerText': '73', 'score': false},
      {'answerText': '83', 'score': false},
    ],
  },
  {
    'question': '2+13',
    'answers': [
      {'answerText': '20', 'score': false},
      {'answerText': '17', 'score': false},
      {'answerText': '15', 'score': true},
      {'answerText': '21', 'score': false},
    ],
  },
  {
    'question': '44+50',
    'answers': [
      {'answerText': '84', 'score': false},
      {'answerText': '94', 'score': true},
      {'answerText': '100', 'score': false},
      {'answerText': '74', 'score': false},
    ],
  },
  {
    'question': '48+4',
    'answers': [
      {'answerText': '54', 'score': false},
      {'answerText': '62', 'score': false},
      {'answerText': '52', 'score': true},
      {'answerText': '64', 'score': false},
    ],
  },
  {
    'question': '5+62',
    'answers': [
      {'answerText': '87', 'score': false},
      {'answerText': '65', 'score': false},
      {'answerText': '77', 'score': false},
      {'answerText': '67', 'score': true},
    ],
  },
  {
    'question': '8+24',
    'answers': [
      {'answerText': '32', 'score': true},
      {'answerText': '44', 'score': false},
      {'answerText': '35', 'score': false},
      {'answerText': '42', 'score': false},
    ],
  },
  {
    'question': '44+50+24',
    'answers': [
      {'answerText': '118', 'score': true},
      {'answerText': '114', 'score': false},
      {'answerText': '120', 'score': false},
      {'answerText': '98', 'score': false},
    ],
  },
  {
    'question': '66+22+33',
    'answers': [
      {'answerText': '119', 'score': false},
      {'answerText': '122', 'score': false},
      {'answerText': '121', 'score': true},
      {'answerText': '109', 'score': false},
    ],
  },
  {
    'question': '4+50+17',
    'answers': [
      {'answerText': '71', 'score': true},
      {'answerText': '81', 'score': false},
      {'answerText': '61', 'score': false},
      {'answerText': '70', 'score': false},
    ],
  },
];
