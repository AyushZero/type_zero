import 'package:flutter/material.dart';

class WordButton extends StatelessWidget {
  final double? left;
  final double? right;
  final double top;
  final String text;
  final VoidCallback onPressed;

  WordButton({this.left, this.right, required this.top, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      child: SizedBox(
        width: 120,
        height: 160,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[700],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(text, style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
