import 'package:flutter/material.dart';
import 'package:lingocore/lesson_pages.dart';
import 'package:lingocore/widgets/common_widgets.dart';

class TrueFalseQuestion extends StatelessWidget {
  final Question question;
  final Function(String) callback;
  const TrueFalseQuestion({super.key, required this.question, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(100.0),
          child: Text(question.questionText),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ButtonWidget(text: 'Doğru', buttonFunction: () => callback('Şık 1')),
            ButtonWidget(text: 'Yanlış', buttonFunction: () => callback('Yanlış')),
          ],
        ),
      ],
    );
  }
}

class MultipleChoiceQuestion extends StatelessWidget {
  final Question question;
  final Function(String) callback;
  const MultipleChoiceQuestion({super.key, required this.question, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: Text(question.questionText),
        ),
        Column(
          children:
              question.options
                  ?.map(
                    (option) =>
                        ButtonWidget(text: option, buttonFunction: () => callback(option)),
                  )
                  .toList() ??
              [],
        ),
      ],
    );
  }
}
