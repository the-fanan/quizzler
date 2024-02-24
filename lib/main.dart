import 'package:flutter/material.dart';

void main() {
  runApp(const Quizzler());
}

class QuizzPage extends StatefulWidget {
  const QuizzPage({super.key});

  @override
  State<QuizzPage> createState() => _QuizzPageState();
}

class _QuizzPageState extends State<QuizzPage> {
  List<Icon> scoreKeeper = [];
  static const List<Map<String, Object>> questions = [
    {
      'question': 'You can lead a cow down stairs but not up stairs',
      'answer': false,
    },
    {
      'question': 'Approximately one quarter of human bones are in the feet',
      'answer': true,
    },
    {
      'question': 'A slug\'s blood is green',
      'answer': true,
    },
  ];
  int currentQuestionIndex = 0;
  String question = questions[0]['question'].toString();

  void handleAnswer(bool answer) {
    Map<String, Object> currentQuestion = questions[currentQuestionIndex];
    bool expectedAnswer = currentQuestion['answer'].toString() == 'true';
    Color color = Colors.red;
    IconData icon = Icons.close;

    if (answer == expectedAnswer) {
      color = Colors.green;
      icon = Icons.check;
    }

    setState(() {
      currentQuestionIndex = (currentQuestionIndex + 1) % questions.length;
      question = questions[currentQuestionIndex]['question'].toString();
      scoreKeeper.add(Icon(
        icon,
        color: color,
      ));
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
                handleAnswer(true);
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
                handleAnswer(false);
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
                setState(() {
                  currentQuestionIndex = 0;
                  scoreKeeper = [];
                  question = questions[0]['question'].toString();
                });
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
