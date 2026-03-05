import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  const StyledText(this.text, {super.key, this.font_size = 28});

  final String text;
  final double font_size;

  @override
  Widget build(context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: font_size,
      ),
    );
  }
}
