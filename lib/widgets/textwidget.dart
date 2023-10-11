import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String textMessage;
  final Color textColor;
  final double textSize;
  const TextWidget({super.key, required this.textMessage, required this.textColor, required this.textSize});

  @override
  Widget build(BuildContext context) {
    return Text(textMessage , style: TextStyle(
      color: textColor,
      fontSize: textSize,
      fontWeight: FontWeight.bold 
    ),);
  }
}