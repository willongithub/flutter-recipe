import 'dart:convert';
import 'package:chopper/chopper.dart';

import 'package:recipes/models/models.dart';

// implement the Chopper Converter abstract class.
class ModelConverter implements Converter {
  // Override convertRequest(), which takes in a request and returns a new
  // request.
  @override
  Request convertRequest(Request request) {
    // Add a header to the request that says you have a request type of
    // application/json using jsonHeaders. These constants are part of Chopper.
    final req = applyHeader(
      request,
      contentTypeKey,
      jsonHeaders,
      override: false,
    );

    // Call encodeJson() to convert the request to a JSON-encoded one, as
    // required by the server API.
    return encodeJson(req);
  }

  Request encodeJson(Request request) {
    // 1
    final contentType = request.headers[contentTypeKey];
    // 2
    if (contentType != null && contentType.contains(jsonHeaders)) {
      // 3
      return request.copyWith(body: json.encode(request.body));
    }
    return request;
  }

  Response<BodyType> decodeJson<BodyType, InnerType>(Response response) {
    final contentType = response.headers[contentTypeKey];
    var body = response.body;
    // 1
    if (contentType != null && contentType.contains(jsonHeaders)) {
      body = utf8.decode(response.bodyBytes);
    }
    try {
      // 2
      final mapData = json.decode(body);
      // 3
      if (mapData['status'] != null) {
        return response.copyWith<BodyType>(
            body: Error(Exception(mapData['status'])) as BodyType);
      }
      // 4
      final recipeQuery = APIRecipeQuery.fromJson(mapData);
      // 5
      return response.copyWith<BodyType>(
          body: Success(recipeQuery) as BodyType);
    } catch (e) {
      // 6
      chopperLogger.warning(e);
      return response.copyWith<BodyType>(
          body: Error(e as Exception) as BodyType);
    }
  }

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) {
    return decodeJson<BodyType, InnerType>(response);
  }
}
