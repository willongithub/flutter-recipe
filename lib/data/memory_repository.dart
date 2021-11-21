import 'dart:core';
import 'dart:async';
// import 'package:flutter/foundation.dart';

import 'repository.dart';
import 'models/models.dart';

// 3
// class MemoryRepository extends Repository with ChangeNotifier {
class MemoryRepository extends Repository {
  // 4
  final List<Recipe> _currentRecipes = <Recipe>[];
  // 5
  final List<Ingredient> _currentIngredients = <Ingredient>[];
  //1
  Stream<List<Recipe>>? _recipeStream;
  Stream<List<Ingredient>>? _ingredientStream;
// 2
  final StreamController _recipeStreamController =
      StreamController<List<Recipe>>();
  final StreamController _ingredientStreamController =
      StreamController<List<Ingredient>>();

  // 3
  @override
  Stream<List<Recipe>> watchAllRecipes() {
    _recipeStream ??= _recipeStreamController.stream as Stream<List<Recipe>>;
    return _recipeStream!;
  }

  // 4
  @override
  Stream<List<Ingredient>> watchAllIngredients() {
    _ingredientStream ??=
        _ingredientStreamController.stream as Stream<List<Ingredient>>;
    return _ingredientStream!;
  }

  @override
  Future<List<Recipe>> findAllRecipes() {
    // 7
    return Future.value(_currentRecipes);
  }

  @override
  Future<Recipe> findRecipeById(int id) {
    // 8
    return Future.value(
        _currentRecipes.firstWhere((recipe) => recipe.id == id));
  }

  @override
  Future<List<Ingredient>> findAllIngredients() {
    // 9
    return Future.value(_currentIngredients);
  }

  @override
  Future<List<Ingredient>> findRecipeIngredients(int recipeId) {
    // 10
    final recipe =
        _currentRecipes.firstWhere((recipe) => recipe.id == recipeId);
    // 11
    final recipeIngredients = _currentIngredients
        .where((ingredient) => ingredient.recipeId == recipe.id)
        .toList();
    return Future.value(recipeIngredients);
  }

  // @override
  // int insertRecipe(Recipe recipe) {
  //   // 12
  //   _currentRecipes.add(recipe);
  //   // 13
  //   if (recipe.ingredients != null) {
  //     insertIngredients(recipe.ingredients!);
  //   }
  //   // 14
  //   notifyListeners();
  //   // 15
  //   return 0;
  // }
  @override
  Future<int> insertRecipe(Recipe recipe) {
    _currentRecipes.add(recipe);
    // 2
    _recipeStreamController.sink.add(_currentRecipes);
    if (recipe.ingredients != null) {
      insertIngredients(recipe.ingredients!);
    }
    // 3
    // 4
    return Future.value(0);
  }

  @override
  Future<List<int>> insertIngredients(List<Ingredient> ingredients) {
    // 16
    _ingredientStreamController.sink.add(_currentIngredients);
    // if (ingredients.length != 0) {
    if (ingredients.isNotEmpty) {
      // 17
      _currentIngredients.addAll(ingredients);
      // 18
      // notifyListeners();
    }
    // 19
    // return <int>[];
    return Future.value([0]);
  }

  @override
  Future<void> deleteRecipe(Recipe recipe) {
    // 20
    _currentRecipes.remove(recipe);
    // 21
    _recipeStreamController.sink.add(_currentRecipes);
    if (recipe.id != null) {
      deleteRecipeIngredients(recipe.id!);
    }
    // 22
    // notifyListeners();
    return Future.value();
  }

  @override
  Future<void> deleteIngredient(Ingredient ingredient) {
    // 23
    _currentIngredients.remove(ingredient);
    _ingredientStreamController.sink.add(_currentIngredients);
    return Future.value();
  }

  @override
  Future<void> deleteIngredients(List<Ingredient> ingredients) {
    // 24
    _currentIngredients
        .removeWhere((ingredient) => ingredients.contains(ingredient));
    _ingredientStreamController.sink.add(_currentIngredients);
    // notifyListeners();
    return Future.value();
  }

  @override
  Future<void> deleteRecipeIngredients(int recipeId) {
    // 25
    _currentIngredients
        .removeWhere((ingredient) => ingredient.recipeId == recipeId);
    _ingredientStreamController.sink.add(_currentIngredients);
    // notifyListeners();
    return Future.value();
  }

  // 6
  @override
  Future init() {
    return Future.value();
  }

  @override
  void close() {
    _recipeStreamController.close();
    _ingredientStreamController.close();
  }
}
