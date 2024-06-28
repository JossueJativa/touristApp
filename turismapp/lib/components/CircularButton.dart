import 'package:flutter/material.dart';

class CircularButton extends StatefulWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;
  final double width;
  final double height;

  const CircularButton({
    Key? key,
    required this.icon,
    required this.color,
    required this.onPressed,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  _CircularButtonState createState() => _CircularButtonState();
}

class _CircularButtonState extends State<CircularButton> {
  @override
  Widget build(BuildContext context) {
    final double paddingValue =
        (widget.width < widget.height ? widget.width : widget.height) / 4;

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(widget.width / 2),
              right: Radius.circular(widget.width / 2),
            ),
          ),
          padding: EdgeInsets.all(paddingValue),
          backgroundColor: widget.color,
          elevation: 2, // Baja elevación para un estilo más plano
          shadowColor: Colors.transparent, // Sin sombra
        ),
        onPressed: widget.onPressed,
        child: Center(
          child: Icon(
            widget.icon,
            color: Colors.white, // Color del icono para buen contraste
            size: (widget.width < widget.height ? widget.width : widget.height) / 2,
          ),
        ),
      ),
    );
  }
}