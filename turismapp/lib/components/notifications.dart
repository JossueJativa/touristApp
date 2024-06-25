import 'package:flutter/material.dart';

class Notifications {
  final String title;
  final BuildContext context;
  final Color color;

  Notifications({
    required this.title,
    required this.context,
    required this.color,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title),
        backgroundColor: color,
      ),
    );
  }
}
