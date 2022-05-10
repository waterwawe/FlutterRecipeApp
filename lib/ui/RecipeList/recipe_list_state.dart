part of 'recipe_list_bloc.dart';

abstract class RecipeListState {
  const RecipeListState();

}

class RecipeListInitial extends RecipeListState {}

class RecipeListLoading extends RecipeListState {}

class RecipeListLoaded extends RecipeListState {
  RecipeResults results;

  RecipeListLoaded({
    required this.results,
  });
}

class RecipeListError extends RecipeListState {
  ErrorResult error;

  RecipeListError({required this.error});
}
