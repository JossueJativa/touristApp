import 'package:flutter/material.dart';

class TextButtonForm extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color textColor;
  final double fontSize;

  const TextButtonForm({
    super.key,
    required this.text,
    required this.onPressed,
    required this.textColor,
    required this.fontSize,
  });

  @override
  _TextButtonFormState createState() => _TextButtonFormState();
}

class _TextButtonFormState extends State<TextButtonForm> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        minimumSize: WidgetStateProperty.all(const Size(88, 36)), // Tamaño estándar mínimo
        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0)), // Padding
      ),
      child: Text(
        widget.text,
        style: TextStyle(
          color: widget.textColor,
          fontSize: widget.fontSize,
        ),
      ),
    );
  }
}