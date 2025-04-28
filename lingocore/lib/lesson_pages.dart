import 'package:flutter/material.dart';
import 'package:lingocore/widgets/questions.dart';

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
        return TrueFalseQuestion(question: question, callback: checkAns);
      case 'multiple_choice':
        return MultipleChoiceQuestion(question: question, callback: checkAns);
      default:
        return ErrorWidget("bilinmeyen soru tipi!");
    }
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
    options: ['evet', 'hayır', 'eveettt', 'hhhh'],
  );

  String correctAns = 'Şık 1';

  void check(String isCorrect) {
    if (isCorrect == correctAns) {
      setState(() {
        score++;
      });
    }

    setState(() {
      currentQuestion++;
    });

    if (currentQuestion > totalQuestions) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LessonEnd(score: score, totalQ: totalQuestions, currentQ: currentQuestion,),
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
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(
                  begin: 0.0,
                  end: (currentQuestion - 1) / totalQuestions,
                ),
                duration: const Duration(milliseconds: 150),
                builder: (context, value, child) {
                  return LinearProgressIndicator(
                    value: value,
                    backgroundColor: const Color.fromARGB(255, 195, 206, 215),
                    color: Colors.blue,
                    minHeight: 20,
                    borderRadius: BorderRadius.circular(10),
                  );
                },
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
  final int score, totalQ, currentQ;
  const LessonEnd({super.key, required this.score, required this.totalQ, required this.currentQ});

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
                value: currentQ - 1 / totalQ,
                minHeight: 20,
                backgroundColor: const Color.fromARGB(255, 195, 206, 215),
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Text(
                "$score / $totalQ",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
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
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                backgroundColor: const Color.fromARGB(255, 157, 233, 160),
                foregroundColor: Colors.black,
                elevation: 0,
              ),
              child: Text("Geri dön", style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
