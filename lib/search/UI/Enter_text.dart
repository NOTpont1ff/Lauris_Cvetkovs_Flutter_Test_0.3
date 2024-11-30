import 'package:flutter/material.dart';

class EnterText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        
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
              "Type a keyword in the search box to find the GIF",
              style: TextStyle(
                fontSize: 20,
                color: const Color.fromARGB(169, 255, 255, 255),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            Divider(color: Color.fromARGB(255, 79, 199, 254), thickness: 2),
            SizedBox(height: 20),
            Text(
              "This app is made by Lauris Cvetkovs, using Flutter version 3.24.3\n\nThe UI is inspired by Giphy itself",
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
