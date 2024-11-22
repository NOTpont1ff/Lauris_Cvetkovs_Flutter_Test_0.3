import 'package:flutter/material.dart';

class BuildAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100, // Explicit height for the custom AppBar
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF4facfe), // Light blue
            Color(0xFF00f2fe), // Cyan
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      alignment: Alignment.center, // Center the title vertically
      child: Text(
        "GIF Search 0.2",
        style: TextStyle(
          fontFamily: 'Arial', // Use a modern sans-serif font to mimic Frutiger
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
      ),
    );
  }
}
