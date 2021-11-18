import 'package:flutter/material.dart';

import '../components/components.dart';
// import '../models/models.dart';

class RecipeGrid extends StatelessWidget {
  final ScrollController scrollController;
  final List<dynamic> hits;

  const RecipeGrid({
    Key? key,
    required this.scrollController,
    required this.hits,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get the device’s screen size. You then set a fixed
    // item height and create two columns of cards whose width is half the
    // device’s width.
    // final size = MediaQuery.of(context).size;
    const itemColumn = 1;
    // const itemHeight = 310;
    // final itemWidth = size.width / itemColumn;
    // final itemHeight = itemWidth;
    // 3
    return Flexible(
      // 4
      child: GridView.builder(
        // Use scrollController, created in initState(), to detect when
        // scrolling gets to about 70% from the bottom.
        controller: scrollController,
        // 6
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: itemColumn,
          // childAspectRatio: (itemWidth / itemHeight),
        ),
        // 7
        itemCount: hits.length,
        // 8
        itemBuilder: (BuildContext context, int index) {
          return _buildRecipeCard(context, hits, index);
          // return RecipeThumbnail(context, hits, index);
        },
      ),
    );
  }

  Widget _buildRecipeCard(
    BuildContext topLevelContext,
    List<dynamic> hits,
    int index,
  ) {
    // 1
    final recipe = hits[index].recipe;
    return GestureDetector(
      onTap: () {
        Navigator.push(topLevelContext, MaterialPageRoute(
          builder: (context) {
            return const RecipeDetails();
          },
        ));
      },
      // 2
      // child: recipeCard(recipe),
      child: RecipeThumbnail(recipe: recipe),
    );
  }
}

// Pre Chapter 11
// class RecipesGridView extends StatelessWidget {
//   // 1
//   final List<SimpleRecipe> recipes;

//   const RecipesGridView({
//     Key? key,
//     required this.recipes,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // 2
//     return Padding(
//       padding: const EdgeInsets.only(
//         left: 16,
//         right: 16,
//         top: 16,
//       ),
//       // 3
//       child: GridView.builder(
//         // 4
//         itemCount: recipes.length,
//         // 5
//         gridDelegate:
//             const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
//         itemBuilder: (context, index) {
//           // 6
//           final simpleRecipe = recipes[index];
//           return RecipeThumbnail(recipe: simpleRecipe);
//         },
//       ),
//     );
//   }
// }
