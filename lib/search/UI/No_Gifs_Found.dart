import 'package:flutter/material.dart';

class NoGifsFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.4),
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
              "No Gifs Found :(",
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
              "Try searching something else",
              style: TextStyle(
                fontSize: 20,
                color: const Color.fromARGB(169, 255, 255, 255),
              ),
              textAlign: TextAlign.center,
            ),
            
          ],
        ),
      ),
    );
  }
}
