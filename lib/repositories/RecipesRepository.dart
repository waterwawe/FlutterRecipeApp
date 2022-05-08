import 'package:flutter_recipe/models/RecipeResults.dart';
import 'package:dio/dio.dart';
import '../models/ErrorResult.dart';

class RecipesRepository{

  Future<RecipeResults> searchRecipes(String queryString) async {
    var url =
        "https://api.edamam.com/api/recipes/v2?type=public&q=$queryString&app_id=c0857fc8&app_key=8a3d7f628aee1f9abc6077eb28708fb4";

    var response = await Dio().get(url);

    if (response.statusCode == 200) {
      return RecipeResults.fromJson(response.data);
    } else if (response.statusCode == 401) {
      throw ErrorResult(statusCode: 401, message: response.data['message']);
    } else {
      throw ErrorResult(
          statusCode: response.statusCode!, message: response.statusMessage!);
    }
  }
}