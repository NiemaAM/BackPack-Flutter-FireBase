import 'package:firstapp/jeux/Quiz/reponse.dart';
import 'package:firstapp/widgets/app_text.dart';
import 'package:firstapp/widgets/menue_retour.dart';
import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<Icon> _scoreTracker = [];
  int _questionIndex = 0;
  int _totalScore = 0;
  bool answerWasSelected = false;
  bool endOfQuiz = false;
  bool correctAnswerSelected = false;

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
              image: AssetImage("assets/img/page_parametres.png"),
              fit: BoxFit.cover)),
      child: Center(
        child: Column(
          children: [
            retour(),
            SizedBox(
              height: width / 4,
            ),
            // ignore: sdk_version_ui_as_code
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
              width: double.infinity,
              height: height / 5,
              margin:
                  const EdgeInsets.only(bottom: 10.0, left: 30.0, right: 30.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: AppText(
                  text: _questions[_questionIndex]['question'],
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ),
            // ignore: sdk_version_ui_as_code
            ...(_questions[_questionIndex]['answers']
                    as List<Map<String, Object>>)
                .map(
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
    'question': 'Question 1',
    'answers': [
      {'answerText': 'Reponse 1', 'score': true},
      {'answerText': 'Reponse 2', 'score': false},
      {'answerText': 'Reponse 3', 'score': false},
    ],
  },
  {
    'question': 'Question 2',
    'answers': [
      {'answerText': 'Reponse 1', 'score': false},
      {'answerText': 'Reponse 2', 'score': false},
      {'answerText': 'Reponse 3', 'score': true},
    ],
  },
  {
    'question': 'Question 3',
    'answers': [
      {'answerText': 'Reponse 1', 'score': false},
      {'answerText': 'Reponse 2', 'score': false},
      {'answerText': 'Reponse 3', 'score': true},
    ],
  },
  {
    'question': 'Question 4',
    'answers': [
      {'answerText': 'Reponse 1', 'score': false},
      {'answerText': 'Reponse 2', 'score': true},
      {'answerText': 'Reponse 3', 'score': false},
    ],
  },
  {
    'question': 'Question 5',
    'answers': [
      {'answerText': 'Reponse 1', 'score': true},
      {'answerText': 'Reponse 2', 'score': false},
      {'answerText': 'Reponse 3', 'score': false},
    ],
  },
  {
    'question': 'Question 6',
    'answers': [
      {'answerText': 'Reponse 1', 'score': true},
      {'answerText': 'Reponse 2', 'score': false},
      {'answerText': 'Reponse 3', 'score': false},
    ],
  },
  {
    'question': 'Question 7',
    'answers': [
      {'answerText': 'Reponse 1', 'score': true},
      {'answerText': 'Reponse 2', 'score': false},
      {'answerText': 'Reponse 3', 'score': false},
    ],
  },
  {
    'question': 'Question 8',
    'answers': [
      {'answerText': 'Reponse 1', 'score': false},
      {'answerText': 'Reponse 2', 'score': false},
      {'answerText': 'Reponse 3', 'score': true},
    ],
  },
  {
    'question': 'Question 9',
    'answers': [
      {'answerText': 'Reponse 1', 'score': false},
      {'answerText': 'Reponse 2', 'score': false},
      {'answerText': 'Reponse 3', 'score': true},
    ],
  },
  {
    'question': 'Question 10',
    'answers': [
      {'answerText': 'Reponse 1', 'score': false},
      {'answerText': 'Reponse 2', 'score': false},
      {'answerText': 'Reponse 3', 'score': true},
    ],
  },
];
