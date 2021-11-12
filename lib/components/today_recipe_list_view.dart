import 'package:flutter/material.dart';

// 1
import '../components/components.dart';
import '../models/models.dart';

class TodayRecipeListView extends StatelessWidget {
  // 2
  final List<ExploreRecipe> recipes;

  const TodayRecipeListView({
    Key? key,
    required this.recipes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 3
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
      ),
      // 4
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 5
          Text('Recipes of the Day 🍳',
              style: Theme.of(context).textTheme.headline1),
          // 6
          const SizedBox(height: 16),
          // 7
          Container(
            height: 400,
            // 透明背景
            color: Colors.transparent,
            // 创建分隔ListView
            child: ListView.separated(
              // 横向滚动
              scrollDirection: Axis.horizontal,
              // 设置列表项数目
              itemCount: recipes.length,
              // 构建内容项
              itemBuilder: (context, index) {
                // 取出相应列表项
                final recipe = recipes[index];
                return buildCard(recipe);
              },
              // 构建分隔项
              separatorBuilder: (context, index) {
                // 用SizedBox进行分隔
                return const SizedBox(width: 16);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(ExploreRecipe recipe) {
    if (recipe.cardType == RecipeCardType.card1) {
      return Card1(recipe: recipe);
    } else if (recipe.cardType == RecipeCardType.card2) {
      return Card2(recipe: recipe);
    } else if (recipe.cardType == RecipeCardType.card3) {
      return Card3(recipe: recipe);
    } else {
      throw Exception('This card doesn\'t exist yet');
    }
  }
}
