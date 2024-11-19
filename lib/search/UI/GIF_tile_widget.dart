import 'package:flutter/material.dart';
import 'package:gif_with_bloc/model/gif_model.dart';

class GifTileWidget extends StatelessWidget {
  final GifModel gifModel;
  const GifTileWidget({super.key, required this.gifModel});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.teal),
            color: Colors.teal[500],
            ),
        child: Column(
          children: [
            
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: SizedBox.fromSize(
                size: const Size.fromRadius(144),
                child: Image.network(
                  gifModel.url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ));
  }
}
