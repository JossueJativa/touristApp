import 'package:flutter/material.dart';

class ButtonForm extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color principalColor;
  final Color onPressedColor;
  final Color textColor;

  const ButtonForm(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.principalColor,
      required this.onPressedColor,
      required this.textColor});

  @override
  _ButtonFormState createState() => _ButtonFormState();
}

class _ButtonFormState extends State<ButtonForm> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.grey.withOpacity(0.5),
          padding: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          backgroundColor: widget.principalColor,
          foregroundColor: widget.textColor,
          elevation: 5,
        ).copyWith(
          elevation: WidgetStateProperty.resolveWith<double>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.hovered)) {
                return 10;
              }
              if (states.contains(WidgetState.pressed)) {
                return 2;
              }
              return 5;
            },
          ),
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return widget.onPressedColor;
              }
              return widget.principalColor;
            },
          ),
        ),
        child: Text(widget.text),
      ),
    );
  }
}
