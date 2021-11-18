import 'package:http/http.dart';

import 'package:recipes/api/keys.dart';

const String apiKey = key;
const String apiId = id;
// old API base.
const String apiUrl = url_search;

class RecipeService {
  // 1
  Future getData(String url) async {
    // 2
    print('Calling url: $url');
    // 3
    final response = await get(Uri.parse(url));
    // 4
    if (response.statusCode == 200) {
      // 5
      return response.body;
    } else {
      // 6
      print(response.statusCode);
    }
  }

  // 1
  Future<dynamic> getRecipes(String query, int from, int to) async {
    // 2
    final recipeData = await getData(
        '$apiUrl?app_id=$apiId&app_key=$apiKey&q=$query&from=$from&to=$to');
    // 3
    return recipeData;
  }
}
