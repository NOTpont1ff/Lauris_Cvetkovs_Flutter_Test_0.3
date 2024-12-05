import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gif_with_bloc/API/giphy_api.dart';
import 'package:gif_with_bloc/search/bloc/search_bloc.dart';
import 'package:gif_with_bloc/search/UI/SearchScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GIF Search',
      theme: ThemeData.dark(),
      home: BlocProvider(
        create: (context) => SearchBloc(giphyApi: GiphyApi(), connectivity: Connectivity()), // Providing the bloc here
        child: SearchScreen(),
      ),
    );
  }
}
