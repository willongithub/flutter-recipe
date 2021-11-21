import 'package:chopper/chopper.dart';

import 'package:recipes/models/models.dart';
import 'keys.dart';
import 'service_interface.dart';

part 'recipe_service.chopper.dart';

const String apiKey = key;
const String apiId = id;
const String apiUrl = url_chopper;
// const String apiUrl = url_v2;

// Tells the Chopper generator to build a part file. This generated file will
// have the same name as this file, but with .chopper added to it.
@ChopperApi()
// RecipeService is an abstract class because you only need to define the
// method signatures. The generator script will take these definitions and
// generate all the code needed.
abstract class RecipeService extends ChopperService
    implements ServiceInterface {
  // @Get is an annotation that tells the generator this is a GET request with
  // a path named search, which you previously removed from the apiUrl. There
  // are other HTTP methods you can use, such as @Post, @Put and @Delete.
  @override
  @Get(path: 'search')
  // returns a Future of a Response using the previously created APIRecipeQuery.
  // The abstract Result that you created above will hold either a value or an
  // error.
  Future<Response<Result<APIRecipeQuery>>> queryRecipes(
    // queryRecipes() uses the Chopper @Query annotation to accept a query
    // string and from and to integers. This method doesn’t have a body. The
    // generator script will create the body of this function with all the
    // parameters.
    @Query('q') String query,
    // @Query('from') int from,
    // @Query('to') int to);
    @Query('start') int start,
    @Query('limit') int limit,
  );

  static RecipeService create() {
    // 1
    final client = ChopperClient(
      // 2
      baseUrl: apiUrl,
      // Pass in two interceptors. _addQuery() adds your key and ID to the
      // query. HttpLoggingInterceptor is part of Chopper and logs all calls.
      // It’s handy while you’re developing to see traffic between the app and
      // the server.
      interceptors: [_addQuery, HttpLoggingInterceptor()],
      // Set the converter as an instance of ModelConverter.
      converter: ModelConverter(),
      // Use the built-in JsonConverter to decode any errors.
      errorConverter: const JsonConverter(),
      // Define the services created when you run the generator script.
      services: [
        _$RecipeService(),
      ],
    );
    // Return an instance of the generated service.
    return _$RecipeService(client);
  }
}

Request _addQuery(Request req) {
  // 1
  final params = Map<String, dynamic>.from(req.parameters);
  // 2
  params['app_id'] = apiId;
  params['app_key'] = apiKey;
  // 3
  return req.copyWith(parameters: params);
}
