import 'package:flutter/material.dart';
import 'package:lingocore/widgets/questions.dart';
import 'package:lingocore/widgets/common_question_button.dart';

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

// Function to create a question widget based on the type
Widget questionWidget({
  required Question question,
  required Function(String) callback,
  required List<String> answerList,
  required bool isPressAllowed,
  required List<String> correctAnswer,
}) {
  switch (question.type) {
    case 'true_false':
      return TrueFalseQuestion(question: question, callback: callback);
    case 'multiple_choice':
      return MultipleChoiceQuestion(
        question: question,
        callback: callback,
        answerList: answerList,
        isPressAllowed: isPressAllowed,
        correctAnswer: correctAnswer,
      );
    default:
      return ErrorWidget("Bilinmeyen soru tipi!");
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
  List<String> answerList = [];
  bool isQuestionAnswered = false; // Variable to check if question is answered

  final Question question = Question(
    type: 'multiple_choice',
    questionText: 'Question Text',
    options: ['I', 'He', 'She', 'Are', 'Computer', 'Am', 'Engineer', 'It'],
  );

  List<String> correctAnswer = ['I', 'Am', 'Engineer'];

  // Function to check if the answer was already selected
  void toggleAnswerButtons(String answer) {
    setState(() {
      if (answerList.contains(answer)) {
        answerList.remove(answer);
      } else {
        answerList.add(answer);
      }
    });
  }

  // Function to check if the answer is correct
  bool checkAnswer() {
    if (answerList.length != correctAnswer.length) return false;
    for (int i = 0; i < answerList.length; i++) {
      if (answerList[i] != correctAnswer[i]) return false;
    }
    return true;
  }

  // Function to switch between the answer and continue button
  void toggleContinueButton() {
    if (isQuestionAnswered) {
      setState(() {
        isQuestionAnswered = false;
        currentQuestion++;
        answerList.clear();
      });
      if (currentQuestion > totalQuestions) {
        setState(() {
          currentQuestion = 1;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) => LessonEnd(
                  score: score,
                  totalQ: totalQuestions,
                  currentQ: currentQuestion,
                  
                ),
          ),
        );
      }
    } else {
      setState(() {
        isQuestionAnswered = true;
        if (checkAnswer()) {
          score++;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: SizedBox(
          width: screenWidth * 0.95,
          height: screenHeight * 0.95,
          child: Column(
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween<double>(
                  begin: 0.0,
                  end: (currentQuestion - 1) / totalQuestions,
                ),
                duration: const Duration(milliseconds: 150),
                builder: (context, value, child) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: value,
                      backgroundColor:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
                      color: Colors.blue,
                      minHeight: 15,
                    ),
                  );
                },
              ),
              questionWidget(
                question: question,
                callback: toggleAnswerButtons,
                answerList: answerList,
                isPressAllowed: !isQuestionAnswered,
                correctAnswer: correctAnswer,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: CommonButton(
                    text: isQuestionAnswered ? "devam et" : "cevapla",
                    onPressed: () => toggleContinueButton(),
                    backgroundColor:
                        isQuestionAnswered
                            ? Colors.teal[400]!
                            : Colors.deepOrangeAccent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LessonEnd extends StatelessWidget {
  final int score, totalQ, currentQ;

  const LessonEnd({
    super.key,
    required this.score,
    required this.totalQ,
    required this.currentQ,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Test bitti!",
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),

            Text(
              "$score / $totalQ",
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),

            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.02,
                  horizontal: screenWidth * 0.02,
                ),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.black,
                elevation: 0,
              ),
              child: Text("Geri dön", style: TextStyle(fontSize: 30)),
            ),
          ],
        ),
      ),
    );
  }
}
