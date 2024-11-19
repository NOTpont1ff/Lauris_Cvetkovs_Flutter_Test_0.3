import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gif_with_bloc/search/UI/GIF_tile_widget.dart';
import 'package:gif_with_bloc/search/bloc/search_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchBloc searchBloc = SearchBloc();

  @override
  void initState() {
    // TODO: implement initState
    searchBloc.add(InitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      bloc: searchBloc,
      listenWhen: (previous, current) => current is SearchActionState,
      buildWhen: (previous, current) => current is! SearchActionState,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case SearchLoadingState:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case SearchLoadedSuccessState:
            final successState = state as SearchLoadedSuccessState;
            return Scaffold(
                appBar: AppBar(
                  title: Text('GIF Search 0.2'),
                  titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
                  backgroundColor: Colors.teal[700],
                  centerTitle: true,
                  
                ),
                backgroundColor: Colors.teal[50],
                body: Column(
                  children: [
                    Text("", style: TextStyle(fontSize: 10)),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        color: Colors.teal[200],
                        padding: const EdgeInsets.all(17.0),
                        
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Search for GIFs',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {},
                            ),
                          ),
                          onSubmitted: (value) {
                            searchBloc.add(SearchButtonClicked());
                          },
                        ),
                      ),
                    ),
                    Flexible(
                        child: ListView.builder(
                            itemCount: successState.gifs.length,
                            itemBuilder: (context, index) {
                              return GifTileWidget(
                                  gifModel: successState.gifs[index]);
                            }))
                  ],
                ));
          case SearchErrorSuccessState:
            return Scaffold(
              body: Center(
                child: Text("ERROR"),
              ),
            );
          default:
            return SizedBox();
        }
      },
    );
  }

  // Widget _buildSearchBar() {
  //   return Scaffold(
  //     backgroundColor: Colors.teal,
  //     body: Column(
  //       children: [Expanded(child: Text("hui"))],
  //     ),

  // padding: const EdgeInsets.all(17.0),
  // child: TextField(
  //   color: Colors.teal[700],
  //   decoration: InputDecoration(
  //     labelText: 'Search for GIFs',
  //     suffixIcon: IconButton(
  //       icon: Icon(Icons.search),
  //       onPressed: () {},
  //     ),
  //   ),
  //   onSubmitted: (value) {
  //     searchBloc.add(SearchButtonClicked());
  //   },
  // ),
//     );
//   }
}
