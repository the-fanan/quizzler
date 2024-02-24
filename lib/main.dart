import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(const Quizzler());
}

class QuizzPage extends StatefulWidget {
  const QuizzPage({super.key});

  @override
  State<QuizzPage> createState() => _QuizzPageState();
}

class Question {
  final String question;
  final bool answer;

  const Question({this.question = '', this.answer = false});
}

class _QuizzPageState extends State<QuizzPage> {
  List<Icon> scoreKeeper = [];
  static const List<Question> questions = [
    Question(
      question: 'You can lead a cow down stairs but not up stairs',
      answer: false,
    ),
    Question(
      question: 'Approximately one quarter of human bones are in the feet',
      answer: true,
    ),
    Question(
      question: 'A slug\'s blood is green',
      answer: true,
    ),
  ];
  int currentQuestionIndex = 0;
  int correctQuestions = 0;
  String question = questions[0].question;

  void handleAnswer(BuildContext context, bool answer) {
    Question currentQuestion = questions[currentQuestionIndex];
    bool expectedAnswer = currentQuestion.answer;
    Color color = Colors.red;
    IconData icon = Icons.close;

    if (answer == expectedAnswer) {
      color = Colors.green;
      icon = Icons.check;
      correctQuestions++;
    }

    setState(() {
      currentQuestionIndex = currentQuestionIndex + 1;

      if (currentQuestionIndex >= questions.length) {
        Alert(
          context: context,
          title: 'End Of Questions',
          desc:
              'You have reached the end of the questions. You got $correctQuestions of ${questions.length} questions correct!',
          buttons: [
            DialogButton(
              color: Colors.red,
              onPressed: () {
                resetState();
                Navigator.pop(context);
              },
              width: 120,
              child: const Text(
                "Close",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ).show();
      }

      question = questions[currentQuestionIndex].question;
      scoreKeeper.add(Icon(
        icon,
        color: color,
      ));
    });
  }

  void resetState() {
    setState(() {
      currentQuestionIndex = 0;
      scoreKeeper = [];
      question = questions[0].question;
      correctQuestions = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                question,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.green),
              ),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                handleAnswer(context, true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.red),
              ),
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                handleAnswer(context, false);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.blue),
              ),
              child: const Text(
                'Restart',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                resetState();
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: QuizzPage(),
          ),
        ),
      ),
    );
  }
}
