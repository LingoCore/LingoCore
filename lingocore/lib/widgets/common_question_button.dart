import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final double inPaddingVertical;
  final double inPaddingHorizontal;
  final double fontSize;
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool isEnabled;

  const CommonButton({
    super.key,
    this.inPaddingVertical = 20,
    this.inPaddingHorizontal = 10,
    this.fontSize = 20,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.blueAccent,
    this.foregroundColor = Colors.white,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: inPaddingVertical,
          horizontal: inPaddingHorizontal,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      onPressed: isEnabled ? onPressed : () {},
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize),
        textAlign: TextAlign.center,
      ),
    );
  }
}
