import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart' show rootBundle;

import 'package:http/http.dart' as http;
import 'package:chopper/chopper.dart';

import '../models/rest_response.dart';
import '../models/recipe_model.dart';

class MockService {
  // 1
  late APIRecipeQuery _currentRecipes1;
  late APIRecipeQuery _currentRecipes2;
  // 2
  Random nextRecipe = Random();

  // 3
  void create() {
    loadRecipes();
  }

  void loadRecipes() async {
    // 4
    var jsonString = await rootBundle.loadString(
      'assets/sample_data/recipes1.json',
    );
    // 5
    _currentRecipes1 = APIRecipeQuery.fromJson(jsonDecode(jsonString));
    jsonString = await rootBundle.loadString(
      'assets/sample_data/recipes2.json',
    );
    _currentRecipes2 = APIRecipeQuery.fromJson(jsonDecode(jsonString));
  }

  Future<Response<Result<APIRecipeQuery>>> queryRecipes(
      String query, int from, int to) {
    // 6
    switch (nextRecipe.nextInt(2)) {
      case 0:
        // 7
        return Future.value(
          Response(
            http.Response('Dummy', 200, request: null),
            Success<APIRecipeQuery>(_currentRecipes1),
          ),
        );
      case 1:
        return Future.value(
          Response(
            http.Response('Dummy', 200, request: null),
            Success<APIRecipeQuery>(_currentRecipes2),
          ),
        );
      default:
        return Future.value(
          Response(
            http.Response('Dummy', 200, request: null),
            Success<APIRecipeQuery>(_currentRecipes1),
          ),
        );
    }
  }
}
