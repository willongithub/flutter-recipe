import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import '../models/models.dart';

class RecipeThumbnail extends StatelessWidget {
  // 1
  // final SimpleRecipe recipe;
  final APIRecipe recipe;

  const RecipeThumbnail({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 2
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      // 3
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 15),
          // 4
          Expanded(
            // 剪裁得到圆角矩形
            child: ClipRRect(
              // child: Image.asset(
              //   recipe.dishImage,
              //   fit: BoxFit.cover,
              // ),
              borderRadius: BorderRadius.circular(12.0),
              child: CachedNetworkImage(
                imageUrl: recipe.image,
                height: 200,
                fit: BoxFit.fill,
              ),
            ),
          ),
          // 6
          const SizedBox(height: 10),
          // 7
          Text(
            // recipe.title,
            recipe.label,
            maxLines: 1,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            // recipe.duration,
            getCalories(recipe.calories),
            style: Theme.of(context).textTheme.bodyText2,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
