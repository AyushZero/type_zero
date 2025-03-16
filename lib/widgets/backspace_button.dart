import 'package:flutter/material.dart';

class BackspaceButton extends StatelessWidget {
  final VoidCallback onTap;

  BackspaceButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 1,
      bottom: 1,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.grey[700],
            borderRadius: BorderRadius.only(topRight: Radius.circular(70)),
          ),
          child: Center(
            child: Icon(Icons.backspace, color: Colors.white, size: 15),
          ),
        ),
      ),
    );
  }
}
