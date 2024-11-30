import 'package:flutter/material.dart';

class BuildAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: 
    Container(
      height: 70,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 79, 199, 254),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        
      ),
      alignment: Alignment.center,
      child: Text(
        "GIF Search 0.3",
        style: TextStyle(
          fontFamily: 'Arial',
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          
        ),
      ),
    ));
  }
}
