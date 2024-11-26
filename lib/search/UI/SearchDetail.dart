import 'package:flutter/material.dart';
import 'package:gif_with_bloc/model/gif_model.dart';

class SearchDetail extends StatelessWidget {
  final GifModel gifModel;
  const SearchDetail({super.key, required this.gifModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.9),
                  blurRadius: 14,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
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
                  SizedBox(height: 20),
                  Text(
                    "GIF ID: ${gifModel.id}",
                    style: TextStyle(
                      fontSize: 20,
                      color: const Color.fromARGB(169, 255, 255, 255),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Divider(color: Colors.blue.withOpacity(0.5), thickness: 1),
                  SizedBox(height: 20),
                  Text(
                    "GIF title: ${gifModel.title}",
                    style: TextStyle(
                      fontSize: 20,
                      color: const Color.fromARGB(169, 255, 255, 255),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Divider(color: Colors.blue.withOpacity(0.5), thickness: 1),
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
