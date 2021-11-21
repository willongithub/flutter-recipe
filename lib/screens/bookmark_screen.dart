import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../data/models/recipe.dart';
// import '../../data/memory_repository.dart';
import '../../data/repository.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  List<Recipe> recipes = [];

  // Remove initState()
  // @override
  // void initState() {
  //   super.initState();
  //   recipes = <String>[];
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: _buildRecipeList(context),
    );
  }

  Widget _buildRecipeList(BuildContext context) {
    // return Consumer<MemoryRepository>(
    //   builder: (context, repository, child) {
    //     recipes = repository.findAllRecipes();
// 1
    final repository = Provider.of<Repository>(context, listen: false);
// 2
    return StreamBuilder<List<Recipe>>(
      // 3
      stream: repository.watchAllRecipes(),
      // 4
      builder: (context, AsyncSnapshot<List<Recipe>> snapshot) {
        // 5
        if (snapshot.connectionState == ConnectionState.active) {
          // 6
          final recipes = snapshot.data ?? [];

          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (BuildContext context, int index) {
              final recipe = recipes[index];
              return SizedBox(
                height: 100,
                child: Slidable(
                  actionPane: const SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: Card(
                    elevation: 1.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.white,
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: CachedNetworkImage(
                            imageUrl: recipe.image ?? '',
                            height: 120,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                          title: Text(recipe.label ?? ''),
                        ),
                      ),
                    ),
                  ),
                  // actions: <Widget>[
                  //   IconSlideAction(
                  //     caption: 'Delete',
                  //     color: Colors.transparent,
                  //     foregroundColor: Colors.black,
                  //     iconWidget: const Icon(Icons.delete, color: Colors.red),
                  //     onTap: () => deleteRecipe(repository, recipe),
                  //   ),
                  // ],
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'Delete',
                      color: Colors.transparent,
                      foregroundColor: Colors.black,
                      iconWidget: const Icon(Icons.delete, color: Colors.red),
                      // onTap: () => deleteRecipe(repository, recipe),
                      onTap: () => repository.deleteRecipe(recipe),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return Container();
          // return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void deleteRecipe(Repository repository, Recipe recipe) async {
    if (recipe.id != null) {
      // 1
      repository.deleteRecipeIngredients(recipe.id!);
      // 2
      repository.deleteRecipe(recipe);
      // 3
      setState(() {});
    } else {
      print('Recipe id is null');
    }
  }
}
