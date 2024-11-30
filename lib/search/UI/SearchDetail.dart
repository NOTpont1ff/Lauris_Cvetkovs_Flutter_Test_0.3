import 'package:flutter/material.dart';
import 'package:gif_with_bloc/model/gif_model.dart';
import 'dart:math' as math;

class SearchDetail extends StatelessWidget {
  final GifModel gifModel;
  const SearchDetail({super.key, required this.gifModel});

  @override
  Widget build(BuildContext context) {
     var col = Colors.primaries[math.Random().nextInt(Colors.primaries.length)];
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: col, width: 4)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox.fromSize(
                size: const Size.fromRadius(144),
                child: Image.network(
                  gifModel.url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20),
                  Text(
                    "GIF ID: ${gifModel.id}",
                    style: TextStyle(
                      fontSize: 20,
                      color: const Color.fromARGB(169, 255, 255, 255),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Divider(color: Color.fromARGB(255, 79, 199, 254), thickness: 2),
                  SizedBox(height: 20),
                  Text(
                    "GIF title: ${gifModel.title}",
                    style: TextStyle(
                      fontSize: 20,
                      color: const Color.fromARGB(169, 255, 255, 255),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Divider(color: Color.fromARGB(255, 79, 199, 254), thickness: 2),
                  SizedBox(height: 20),
                  Text(
                    "GIF user: ${gifModel.user}",
                    style: TextStyle(
                      fontSize: 20,
                      color: const Color.fromARGB(169, 255, 255, 255),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
