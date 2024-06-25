import 'package:flutter/material.dart';

class InputForm extends StatefulWidget {
  final IconData icon;
  final String hint;
  final bool isPassword;
  final TextEditingController controller;

  const InputForm({
    super.key,
    required this.icon,
    required this.hint,
    required this.isPassword,
    required this.controller,
  });

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  obscureText: widget.isPassword ? _obscureText : false,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: widget.hint,
                    hintStyle: const TextStyle(color: Colors.black),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    prefixIcon: Icon(
                      widget.icon,
                      color: Colors.black,
                    ),
                    suffixIcon: widget.isPassword
                      ? IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(
                          _obscureText
                            ? Icons.visibility_off
                            : Icons.visibility,
                          color: Colors.black,
                        ),
                      )
                      : null,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
