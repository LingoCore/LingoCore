import 'package:flutter/material.dart';
class ButtonWidget extends StatelessWidget {
  final String text;
  final Function() buttonFunction;
  const ButtonWidget({super.key, required this.text, required this.buttonFunction});

  @override
  Widget build(BuildContext context) {
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
          onPressed: buttonFunction,
          child: Text(text, style: TextStyle(fontSize: 30)),
        ),
      ),
    );
  }
}
