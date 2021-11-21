import 'dart:math';
// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:chopper/chopper.dart';
import 'package:provider/provider.dart';

// import '../api/mock_fooderlich_service.dart';
import '../models/models.dart';
import '../components/components.dart';
// import '../api/recipe_service.dart';
import '../api/mock_service.dart';
import '../api/service_interface.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({Key? key}) : super(key: key);

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  static const String prefSearchKey = 'previousSearches';

  late TextEditingController searchTextController;
  final ScrollController _scrollController = ScrollController();

  // final exploreService = MockFooderlichService();
  List<APIHits> currentSearchList = [];
  // List currentSearchList = [];
  int currentCount = 0;
  int currentStartPosition = 0;
  int currentEndPosition = 5;
  int pageCount = 5;
  bool hasMore = false;
  bool loading = false;
  bool inErrorState = false;
  List<String> previousSearches = <String>[];
  // APIRecipeQuery? _currentRecipes1;

  @override
  void initState() {
    super.initState();
    // loadRecipes();
    getPreviousSearches();
    searchTextController = TextEditingController(text: '');
    _scrollController.addListener(() {
      final triggerFetchMoreSize =
          0.7 * _scrollController.position.maxScrollExtent;
      if (_scrollController.position.pixels > triggerFetchMoreSize) {
        if (hasMore &&
            currentEndPosition < currentCount &&
            !loading &&
            !inErrorState) {
          setState(() {
            loading = true;
            currentStartPosition = currentEndPosition;
            currentEndPosition =
                min(currentStartPosition + pageCount, currentCount);
          });
        }
      }
    });
  }

  // 1
  // Future<APIRecipeQuery> getRecipeData(String query, int from, int to) async {
  //   // 2
  //   final recipeJson = await RecipeService().getRecipes(query, from, to);
  //   // 3
  //   final recipeMap = json.decode(recipeJson);
  //   // 4
  //   return APIRecipeQuery.fromJson(recipeMap);
  // }

  // rootBundle is the top-level property that holds references to all the
  // items in the asset folder. This loads the file as a string.
  // Future loadRecipes() async {
  //   // 1
  //   final jsonString =
  //       await rootBundle.loadString('assets/sample_data/recipes1.json');
  //   setState(() {
  //     // 2
  //     _currentRecipes1 = APIRecipeQuery.fromJson(jsonDecode(jsonString));
  //   });
  // }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    // color: Colors.white,
    // child:
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          _buildSearchCard(),
          _buildRecipeLoader(context),
        ],
      ),
      // ),
    );
    // 2
    // return FutureBuilder(
    //   // 3
    //   future: exploreService.getRecipes(),
    //   builder: (context, AsyncSnapshot<List<SimpleRecipe>> snapshot) {
    //     // 4
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       // 5
    //       return RecipesGridView(recipes: snapshot.data ?? []);
    //     } else {
    //       // 6
    //       return const Center(child: CircularProgressIndicator());
    //     }
    //   },
    // );
  }

  void savePreviousSearches() async {
    // 1
    final prefs = await SharedPreferences.getInstance();
    // 2
    prefs.setStringList(prefSearchKey, previousSearches);
  }

  void getPreviousSearches() async {
    // 1
    final prefs = await SharedPreferences.getInstance();
    // 2
    if (prefs.containsKey(prefSearchKey)) {
      // 3
      final searches = prefs.getStringList(prefSearchKey);
      // 4
      if (searches != null) {
        previousSearches = searches;
      } else {
        previousSearches = <String>[];
      }
    }
  }

  void startSearch(String value) {
    // 1
    setState(() {
      // 2
      currentSearchList.clear();
      currentCount = 0;
      currentEndPosition = pageCount;
      currentStartPosition = 0;
      hasMore = true;
      value = value.trim();

      // 3
      if (!previousSearches.contains(value)) {
        // 4
        previousSearches.add(value);
        // 5
        savePreviousSearches();
      }
    });
  }

  Widget _buildSearchCard() {
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            // Replace
            // const Icon(Icons.search),
            IconButton(
              icon: const Icon(Icons.search),
              // 1
              onPressed: () {
                // 2
                startSearch(searchTextController.text);
                // Hide the keyboard by using the FocusScope class.
                final currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
            ),
            const SizedBox(
              width: 6.0,
            ),
            // *** Start Replace
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                      ),
                      autofocus: false,
                      // Set the keyboard action to TextInputAction.done.
                      // This closes the keyboard when the user presses the
                      // Done button.
                      textInputAction: TextInputAction.done,
                      // 5
                      onSubmitted: (value) {
                        if (!previousSearches.contains(value)) {
                          previousSearches.add(value);
                          savePreviousSearches();
                        }
                      },
                      controller: searchTextController,
                      // onChanged: (query) => {
                      //   if (query.length >= 3)
                      //     {
                      //       // Rebuild list
                      //       setState(
                      //         () {
                      //           currentSearchList.clear();
                      //           currentCount = 0;
                      //           currentEndPosition = pageCount;
                      //           currentStartPosition = 0;
                      //         },
                      //       )
                      //     }
                      // },
                    ),
                  ),
                  // Create a PopupMenuButton to show previous searches.
                  PopupMenuButton(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey[300],
                    ),
                    // When the user selects an item from previous searches,
                    // start a new search.
                    onSelected: (String value) {
                      searchTextController.text = value;
                      startSearch(searchTextController.text);
                    },
                    itemBuilder: (BuildContext context) {
                      // 8
                      return previousSearches
                          .map<CustomDropdownMenuItem<String>>((String value) {
                        return CustomDropdownMenuItem<String>(
                          text: value,
                          value: value,
                          callback: () {
                            setState(() {
                              // 9
                              previousSearches.remove(value);
                              Navigator.pop(context);
                            });
                          },
                        );
                      }).toList();
                    },
                  ),
                ],
              ),
            ),
            // *** End Replace
          ],
        ),
      ),
    );
  }

  Widget _buildRecipeLoader(BuildContext context) {
    // You check there are at least three characters in the search term. You
    // can change this value, but you probably won’t get good results with only
    // one or two characters.
    if (searchTextController.text.length < 3) {
      return Container();
    }

    dynamic _service;

    if (Provider.of<ProfileManager>(context).mockQuery) {
      _service = Provider.of<MockService>(context).queryRecipes(
          searchTextController.text.trim(),
          currentStartPosition,
          currentEndPosition);
    } else {
      // _service = RecipeService.create().queryRecipes(
      //     searchTextController.text.trim(),
      //     currentStartPosition,
      //     currentEndPosition);
      _service = Provider.of<ServiceInterface>(context).queryRecipes(
          searchTextController.text.trim(),
          currentStartPosition,
          currentEndPosition);
    }
    // 2
    // return FutureBuilder<APIRecipeQuery>(
    return FutureBuilder<Response<Result<APIRecipeQuery>>>(
      // 3
      // future: getRecipeData(searchTextController.text.trim(),
      //     currentStartPosition, currentEndPosition),

      // Query from remote
      // future: RecipeService.create().queryRecipes(
      //     searchTextController.text.trim(),
      //     currentStartPosition,
      //     currentEndPosition),

      // Using mock service.
      // future: Provider.of<MockService>(context).queryRecipes(
      //     searchTextController.text.trim(),
      //     currentStartPosition,
      //     currentEndPosition),

      future: _service,

      // 4
      builder: (context, snapshot) {
        // 5
        if (snapshot.connectionState == ConnectionState.done) {
          // 6
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString(),
                  textAlign: TextAlign.center, textScaleFactor: 1.3),
            );
          }

          // 7
          loading = false;
          // final query = snapshot.data;
          // 1
          final result = snapshot.data?.body;
          // If result is an error, return the current list of recipes.
          if (result is Error) {
            // Hit an error
            inErrorState = true;
            // return _buildRecipeList(context, currentSearchList);
            return RecipeGrid(
              scrollController: _scrollController,
              hits: currentSearchList,
            );
          }
          // 3
          final query = (result as Success).value;

          inErrorState = false;
          if (query != null) {
            currentCount = query.count;
            hasMore = query.more;
            currentSearchList.addAll(query.hits);
            // 8
            if (query.to < currentEndPosition) {
              currentEndPosition = query.to;
            }
          }
          // 9
          // return _buildRecipeList(context, currentSearchList);
          return RecipeGrid(
            scrollController: _scrollController,
            hits: currentSearchList,
          );
        }
        // 10
        else {
          // 11
          if (currentCount == 0) {
            // Show a loading indicator while waiting for the recipes
            return const Center(child: CircularProgressIndicator());
          } else {
            // 12
            // return _buildRecipeList(context, currentSearchList);
            return RecipeGrid(
              scrollController: _scrollController,
              hits: currentSearchList,
            );
          }
        }
      },
    );

    // 1
    // if (_currentRecipes1 == null || _currentRecipes1?.hits == null) {
    //   return Container();
    // }
    // // Show a loading indicator while waiting for the recipes
    // return Center(
    //   // 2
    //   child: _buildRecipeCard(context, _currentRecipes1!.hits, 0),
    // );
  }

  // 1
  // Widget _buildRecipeList(BuildContext recipeListContext, List<APIHits> hits) {
  //   // 2
  //   final size = MediaQuery.of(context).size;
  //   const itemHeight = 310;
  //   final itemWidth = size.width / 2;
  //   // 3
  //   return Flexible(
  //     // 4
  //     child: GridView.builder(
  //       // 5
  //       controller: _scrollController,
  //       // 6
  //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 2,
  //         childAspectRatio: (itemWidth / itemHeight),
  //       ),
  //       // 7
  //       itemCount: hits.length,
  //       // 8
  //       itemBuilder: (BuildContext context, int index) {
  //         return _buildRecipeCard(recipeListContext, hits, index);
  //       },
  //     ),
  //   );
  // }

  // Widget _buildRecipeCard(
  //   BuildContext topLevelContext,
  //   List<APIHits> hits,
  //   int index,
  // ) {
  //   // 1
  //   final recipe = hits[index].recipe;
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.push(topLevelContext, MaterialPageRoute(
  //         builder: (context) {
  //           return const RecipeDetails();
  //         },
  //       ));
  //     },
  //     // 2
  //     child: recipeCard(recipe),
  //   );
  // }
}
