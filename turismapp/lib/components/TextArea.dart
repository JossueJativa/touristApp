import 'package:flutter/material.dart';

class TextArea extends StatefulWidget {
  final TextEditingController controller;
  final bool editable;

  const TextArea({super.key, required this.controller, this.editable = true});

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
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          controller: widget.controller,
          maxLines: 10,
          enabled: widget.editable,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: (widget.editable) ? 'Escribe aquí' : 'Texto traducido',
            hintStyle: const TextStyle(color: Colors.black38),
            fillColor: !widget.editable ? Colors.grey.shade200 : Colors.transparent,
          ),
        ),
      ),
    );
  }
}
