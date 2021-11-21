import 'package:chopper/chopper.dart';
import '../models/rest_response.dart';
import '../models/recipe_model.dart';

abstract class ServiceInterface {
  Future<Response<Result<APIRecipeQuery>>> queryRecipes(
      String query, int from, int to);
}
