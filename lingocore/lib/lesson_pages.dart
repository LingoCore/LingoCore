import 'package:flutter/material.dart';

Color backgroundColor = Colors.white;

//Question data
class Question {
  final String type;
  final String questionText;
  final List<String>? options;

  Question({required this.type, required this.questionText, this.options});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      type: json['type'],
      questionText: json['question'],
      options:
          json['options'] != null ? List<String>.from(json['options']) : null,
    );
  }
}

class QuestionWidget extends StatelessWidget {
  final Question question;
  final Function(String userAns) checkAns;
  const QuestionWidget({
    super.key,
    required this.question,
    required this.checkAns,
  });

  @override
  Widget build(BuildContext context) {
    switch (question.type) {
      case 'true_false':
        return buildTrueFalse();
      case 'multiple_choice':
        return buildMultipleChoice();
      default:
        return const Text('bilinmeyen soru tipi');
    }
  }

  Widget buildQuestionText(String text) {
    return Text(question.questionText, style: const TextStyle(fontSize: 30));
  }

  // Generate button
  Widget buildAnswerButton(String label, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.greenAccent, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
            elevation: 0,
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.green, width: 3),
            ),
          ),
          onPressed: onPressed,
          child: Text(label, style: TextStyle(fontSize: 30)),
        ),
      ),
    );
  }

  // True/False Questions
  Widget buildTrueFalse() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(100.0),
          child: buildQuestionText(question.questionText)
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildAnswerButton('Doğru', () => checkAns('Şık 1')),
            buildAnswerButton('Yanlış', () => checkAns('Yanlış')),
          ],
        ),
      ],
    );
  }

  Widget buildMultipleChoice() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: Text(
            question.questionText,
            style: const TextStyle(fontSize: 30),
          ),
        ),
        ...(question.options ?? []).map(
          (option) => buildAnswerButton(option, () => checkAns(option)),
        ),
      ],
    );
  }
}

class LessonPages extends StatefulWidget {
  const LessonPages({super.key});

  @override
  State<LessonPages> createState() => _LessonPagesState();
}

class _LessonPagesState extends State<LessonPages> {
  int currentQuestion = 1;
  int score = 0;
  int totalQuestions = 5;

  final Question question = Question(
    type: 'multiple_choice',
    questionText: 'Soru açıklaması',
    options: ['Şık 1', 'Şık 2', 'Şık 2'],
  );

  String correctAns = 'Şık 1';

  void check(String isCorrect) {
    if (currentQuestion <= totalQuestions) {
      if (isCorrect == correctAns) {
        score++;
      }
      setState(() {
        currentQuestion++;
      });
    }
    if (currentQuestion > totalQuestions) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LessonEnd(score: score, totalQ: totalQuestions),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 50,
              ),
              child: LinearProgressIndicator(
                value: score / totalQuestions,
                backgroundColor: const Color.fromARGB(255, 195, 206, 215),
                color: Colors.blue,
                minHeight: 20,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            QuestionWidget(question: question, checkAns: check),
          ],
        ),
      ),
    );
  }
}


class LessonEnd extends StatelessWidget {
  final int score, totalQ;
  const LessonEnd({required this.score, required this.totalQ});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 100),
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(10),
                value: score / totalQ,
                minHeight: 20,
                backgroundColor:  const Color.fromARGB(255, 195, 206, 215),
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Text("$score / $totalQ", style: TextStyle(
                fontSize: 20,
                color: Colors.black
              ),),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 100),
              child: Text(
                "Testi bitirdiniz!",
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LessonPages()),
                  ),
              child: Text("Geri dön", style: TextStyle(fontSize: 20),),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                backgroundColor: const Color.fromARGB(255, 157, 233, 160),
                foregroundColor: Colors.black,
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
