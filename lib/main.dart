import 'package:flutter/material.dart';
import 'package:biquiz/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(const Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  // void checkAnswer(bool userPickedAnswer) {
  //   bool correctAnswer = quizBrain.getAnswerText();
  //   if (correctAnswer == userPickedAnswer) {
  //     scoreKeeper.add(
  //       Icon(
  //         Icons.check,
  //         color: Colors.green,
  //       ),
  //     );
  //   } else {
  //     scoreKeeper.add(
  //       Icon(
  //         Icons.close,
  //         color: Colors.red,
  //       ),
  //     );
  //   }

  // }

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getAnswerText();

    setState(() {
      if (quizBrain.isFinished() == true) {
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
        ).show();

        quizBrain.reset();

        scoreKeeper = [];
      } else {
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        quizBrain.nextQuestion();
      }
    });
  }

  QuizBrain quizBrain = QuizBrain();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.green),
              onPressed: () {
                setState(() {
                  checkAnswer(true);
                  quizBrain.nextQuestion();
                });
              },
              child: Text('True'),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                setState(() {
                  checkAnswer(false);
                  quizBrain.nextQuestion();
                });
              },
              child: Text('False'),
            ),
          ),
        ),
        Row(children: scoreKeeper),
      ],
    );
  }
}

/*
question1: ' you can lead a cow down stairs but not up stairs.', false,
question2: ' Approximately one quarter of human bones are in the feet.', true,
question3: ' A slug\'s blood is green.', true,
*/
