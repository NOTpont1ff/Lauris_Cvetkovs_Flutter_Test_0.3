import 'package:flutter/material.dart';
import 'package:gif_with_bloc/model/gif_model.dart';
import 'dart:math' as math;

class GifTileWidget extends StatelessWidget {
  final GifModel gifModel;
  const GifTileWidget({super.key, required this.gifModel});

  @override
  Widget build(BuildContext context) {
    var col = Colors.primaries[math.Random().nextInt(Colors.primaries.length)];
    return Container(
      margin: const EdgeInsets.all(1),
      padding: const EdgeInsets.all(1),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: col,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: col, width: 4)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox.fromSize(
                size: const Size.fromRadius(90),
                child: Image.network(
                  gifModel.url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
