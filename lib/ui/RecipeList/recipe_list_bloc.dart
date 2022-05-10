import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_recipe/models/ErrorResult.dart';
import 'package:flutter_recipe/models/RecipeResults.dart';
import 'package:flutter_recipe/repositories/RecipesRepository.dart';

import '../../models/Recipe.dart';

part 'recipe_list_event.dart';

part 'recipe_list_state.dart';

class RecipeListBloc extends Bloc<RecipeListEvent, RecipeListState> {
  final repository = RecipesRepository();

  RecipeListBloc() : super(RecipeListInitial()) {
    on<RecipeListEvent>((event, emit) async {
      if (event is LoadRecipesResults) {
        try {
          emit(RecipeListLoading());
          final results = await repository.searchRecipes(event.queryString);
          emit(RecipeListLoaded(results: results));
        } on ErrorResult catch (e) {
          emit(RecipeListError(error: e));
        } catch (e) {
          print(e.toString());
          emit(RecipeListError(
              error: ErrorResult(statusCode: 400, message: e.toString())));
        }
      }
      else if (event is LoadFavouriteRecipes) {
        try {
          emit(RecipeListLoading());
          final results = await repository.getFavouriteRecipes();
          emit(RecipeListLoaded(results: results));
        } on ErrorResult catch (e) {
          emit(RecipeListError(error: e));
        } catch (e) {
          print(e.toString());
          emit(RecipeListError(
              error: ErrorResult(statusCode: 400, message: e.toString())));
        }
      }

      else if (event is AddToFavourites) {
        try {
          await repository.addRecipeToFavourites(event.recipe);
        } on ErrorResult catch (e) {
          emit(RecipeListError(error: e));
        } catch (e) {
          print(e.toString());
          emit(RecipeListError(
              error: ErrorResult(statusCode: 400, message: e.toString())));
        }
      }

      else if (event is RemoveFromFavourites) {
        try {
          emit(RecipeListLoading());
          await repository.removeRecipeToFavourites(event.recipe.label ?? "");
          final results = await repository.getFavouriteRecipes();
          emit(RecipeListLoaded(results: results));
        } on ErrorResult catch (e) {
          emit(RecipeListError(error: e));
        } catch (e) {
          print(e.toString());
          emit(RecipeListError(
              error: ErrorResult(statusCode: 400, message: e.toString())));
        }
      }
    });
  }
}
