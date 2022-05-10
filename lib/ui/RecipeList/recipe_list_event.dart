part of 'recipe_list_bloc.dart';

abstract class RecipeListEvent extends Equatable {
  const RecipeListEvent();
}

class LoadRecipesResults extends RecipeListEvent {
  String queryString;
  LoadRecipesResults({
    required this.queryString,
  });

  @override
  List<Object> get props => [];
}

class LoadFavouriteRecipes extends RecipeListEvent {
  LoadFavouriteRecipes();

  @override
  List<Object> get props => [];
}

class AddToFavourites extends RecipeListEvent {
  Recipe recipe;
  AddToFavourites({required this.recipe});

  @override
  List<Object> get props => [];
}

class RemoveFromFavourites extends RecipeListEvent {
  Recipe recipe;
  RemoveFromFavourites({required this.recipe});

  @override
  List<Object> get props => [];
}