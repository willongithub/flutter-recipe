import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import 'package:recipes/fooderlich_theme.dart';
import '../../models/recipe_model.dart';
import '../../data/models/models.dart';
// import '../../data/memory_repository.dart';
import '../../data/repository.dart';

class RecipeDetails extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetails({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final repository = Provider.of<MemoryRepository>(context);
    final repository = Provider.of<Repository>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // child: Container(
          // color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: CachedNetworkImage(
                      imageUrl: recipe.image ?? '',
                      // imageUrl:
                      // 'https://www.edamam.com/web-img/e42/e42f9119813e890af34c259785ae1cfb.jpg',
                      alignment: Alignment.topLeft,
                      fit: BoxFit.fill,
                      width: size.width,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: shim),
                        child: const BackButton(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  recipe.label ?? '',
                  // 'Chicken Vesuvio',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Chip(
                    label: Text(getCalories(recipe.calories)),
                    // label: Text('16CAL'),
                  )),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  onPressed: () {
                    repository.insertRecipe(recipe);
                    Navigator.pop(context);
                  },
                  icon: SvgPicture.asset(
                    'assets/images/icon_bookmark.svg',
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Bookmark',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }
}
