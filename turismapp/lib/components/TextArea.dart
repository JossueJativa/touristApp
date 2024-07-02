import 'package:flutter/material.dart';

class TextArea extends StatefulWidget {
  final TextEditingController controller;
  final bool editable;

  const TextArea({Key? key, required this.controller, this.editable = true}) : super(key: key);

  @override
  _TextAreaState createState() => _TextAreaState();
}

class _TextAreaState extends State<TextArea> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 200,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          controller: widget.controller,
          maxLines: 10,
          enabled: widget.editable, // Controla si el campo es editable o no
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: (widget.editable) ? 'Escribe aquí' : 'Texto traducido',
          ),
        ),
      ),
    );
  }
}
