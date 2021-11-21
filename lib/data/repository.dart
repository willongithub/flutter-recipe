import 'models/models.dart';

abstract class Repository {
  // Streams.
  Stream<List<Recipe>> watchAllRecipes();
  Stream<List<Ingredient>> watchAllIngredients();

  // Find methods.
  Future<List<Recipe>> findAllRecipes();
  Future<Recipe> findRecipeById(int id);
  Future<List<Ingredient>> findAllIngredients();
  Future<List<Ingredient>> findRecipeIngredients(int recipeId);

  // insert methods
  Future<int> insertRecipe(Recipe recipe);
  Future<List<int>> insertIngredients(List<Ingredient> ingredients);

  // Delete methods.
  Future<void> deleteRecipe(Recipe recipe);
  Future<void> deleteIngredient(Ingredient ingredient);
  Future<void> deleteIngredients(List<Ingredient> ingredients);
  Future<void> deleteRecipeIngredients(int recipeId);

  // Initializing and closing methods.
  Future init();
  void close();
}
