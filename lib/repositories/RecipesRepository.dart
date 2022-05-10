import 'dart:convert';
import 'package:flutter_recipe/models/RecipeResults.dart';
import 'package:dio/dio.dart';
import '../models/ErrorResult.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Hit.dart';
import '../models/Recipe.dart';

class RecipesRepository{
  static const FAVOURITE_RECIPES = "FAVOURITE_RECIPES";

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

  Future addRecipeToFavourites(Recipe recipe) async {
    final prefs = await SharedPreferences.getInstance();
    RecipeResults results = await getFavouriteRecipes();

    List<Recipe> currentRecipes = results.hits!.map((h) => h.recipe).toList();
    currentRecipes.add(recipe);
    final encoded = currentRecipes.map((rec) => jsonEncode(rec)).toList();
    await prefs.setStringList(FAVOURITE_RECIPES, encoded);
  }

  Future removeRecipeToFavourites(String recipeLabel) async {
    final prefs = await SharedPreferences.getInstance();
    List<Recipe> currentRecipes = (await getFavouriteRecipes()).hits!.map((h) => h.recipe).toList();

    final newRecipes = currentRecipes.where((recipe) => recipe.label != recipeLabel).toList();

    final encoded = newRecipes.map((recipe) => jsonEncode(recipe)).toList();

    await prefs.setStringList(FAVOURITE_RECIPES, encoded);
  }

  Future<RecipeResults> getFavouriteRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> recipeListJson = prefs.getStringList(FAVOURITE_RECIPES) ?? List.empty();
    List<Hit> resultList = recipeListJson.map((element) => Hit(recipe: Recipe.fromFavourite(jsonDecode(element)))).toList();

    return RecipeResults(hits: resultList);
  }
}