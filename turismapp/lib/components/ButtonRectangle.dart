import 'package:flutter/material.dart';

class ButtonRectangle extends StatefulWidget {
  final String text;
  final double width;
  final double height;
  final Color color;
  final VoidCallback onPressed;

  const ButtonRectangle({
    super.key,
    required this.width,
    required this.height,
    required this.color,
    required this.onPressed, required this.text,
  });

  @override
  _ButtonRectangleState createState() => _ButtonRectangleState();
}

class _ButtonRectangleState extends State<ButtonRectangle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: const TextStyle(
              color: Colors.white, // Color del texto
              fontSize: 16.0, // Tamaño del texto
            ),
          ),
        ),
      ),
    );
  }
}
