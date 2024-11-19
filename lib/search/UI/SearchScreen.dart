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
  final TextEditingController _textController =
      TextEditingController(); // Added controller

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
                elevation: 0,
                toolbarHeight: 80,
                backgroundColor: const Color.fromARGB(255, 24, 129, 214),
                centerTitle: true,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 19, 95, 161),
                        Color(0xFF00f2fe)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                ),
                title: Text(
                  'GIF Search 0.2',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://i.pinimg.com/736x/e5/84/e3/e584e3705a240bd65d40fb59918773ac.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Text("", style: TextStyle(fontSize: 10)),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 17.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.6),
                              blurRadius: 10,
                              offset: Offset(-2, -2),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _textController,
                          decoration: InputDecoration(
                            labelText: 'Search for GIFs',
                            labelStyle: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              icon: SizedBox(
                                width: 24,
                                height: 24,
                                child: Image.network(
                                  'https://cdn2.iconfinder.com/data/icons/crystalproject/128x128/apps/search.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              onPressed: () {
                                searchBloc.add(SearchButtonClicked(
                                    text: _textController.text.trim()));
                              },
                            ),
                          ),
                          cursorColor: Color(0xFF4facfe),
                          onSubmitted: (value) {
                            searchBloc.add(SearchButtonClicked(text: value.trim()));
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
                ),
              ),
            );
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
