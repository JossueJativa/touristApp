import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  final String value;
  final Map<String, String> items;
  final ValueChanged<String?> onChanged;

  const CustomDropdownButton(
      {super.key,
      required this.value,
      required this.items,
      required this.onChanged});

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF80DEEA),
          borderRadius: BorderRadius.circular(50.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SizedBox(
          width: 120.0,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: widget.value,
              items: widget.items.entries.map((entry) {
                return DropdownMenuItem<String>(
                  value: entry.key,
                  child: Text(entry.value),
                );
              }).toList(),
              onChanged: widget.onChanged,
              dropdownColor: const Color(0xFF80DEEA),
              style: const TextStyle(color: Colors.black),
              iconEnabledColor: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
