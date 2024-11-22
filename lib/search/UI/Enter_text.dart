import 'package:flutter/material.dart';

class EnterText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 0, 0, 0)
              .withOpacity(0.4), // Frutiger Aero feel
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
            BoxShadow(
              color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(-3, -3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Welcome to GIF Search!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(221, 255, 255, 255),
                shadows: [
                  Shadow(
                    blurRadius: 5,
                    color: Colors.black26,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              "Type a keyword in the search box to find the perfect GIF.",
              style: TextStyle(
                fontSize: 20,
                color: const Color.fromARGB(169, 255, 255, 255),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            Divider(color: Colors.blue.withOpacity(0.5), thickness: 1),
            SizedBox(height: 20),
            Text(
              "This app is made by Lauris Cvetkovs, using Flutter version 3.24.3.\n\nThe UI is inspired by Frutiger Aero style.",
              style: TextStyle(
                fontSize: 20,
                color: const Color.fromARGB(166, 255, 255, 255),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
