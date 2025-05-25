import 'package:flutter/material.dart';
import 'package:lingocore/screens/lesson.dart';
import 'common_question_button.dart';

class TrueFalseQuestion extends StatelessWidget {
  final Question question;
  final Function(String) callback;

  const TrueFalseQuestion({
    super.key,
    required this.question,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}

class MultipleChoiceQuestion extends StatefulWidget {
  final Question question;
  final Function(String) callback;
  final List<String> answerList;
  final List<String> correctAnswer;
  final bool isPressAllowed;

  const MultipleChoiceQuestion({
    super.key,
    required this.question,
    required this.callback,
    required this.answerList,
    required this.isPressAllowed,
    required this.correctAnswer,
  });

  @override
  MultipleChoiceQuestionState createState() => MultipleChoiceQuestionState();
}

class MultipleChoiceQuestionState extends State<MultipleChoiceQuestion> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Function to determine the button color based on the answer
    Color getButtonColor(String option) {
      if (!widget.answerList.contains(option))
        return Theme.of(context).colorScheme.primary;

      if (!widget.isPressAllowed) {
        final index = widget.answerList.indexOf(option);
        final isCorrect =
            index < widget.correctAnswer.length &&
            option == widget.correctAnswer[index];
        return isCorrect ? Colors.green : Colors.red;
      }

      return Colors.blue[200]!;
    }

    return Center(
      child: SizedBox(
        height: screenHeight * 0.8,
        width: screenWidth * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.03),
              child: Center(
                child: Text(
                  widget.question.questionText,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Theme.of(context).colorScheme.onSurface,
                  width: 3,
                ),
              ),
              height: screenHeight * 0.1,
              width: screenWidth * 0.8,
              child: Center(
                child: Text(
                  widget.answerList.join('  '),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.2,
              width: screenWidth * 0.8,
              child: Align(
                alignment: Alignment.center,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 2,
                  runSpacing: 1,
                  children:
                      widget.question.options!.map((option) {
                        //To generate buttons
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 1,
                            horizontal: 1,
                          ),
                          child: CommonButton(
                            text: option,
                            onPressed: () => widget.callback(option),
                            backgroundColor: getButtonColor(option),
                            foregroundColor:
                                Theme.of(context).colorScheme.onPrimary,
                            isEnabled: widget.isPressAllowed,
                          ),
                        );
                      }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
