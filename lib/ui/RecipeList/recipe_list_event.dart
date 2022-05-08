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