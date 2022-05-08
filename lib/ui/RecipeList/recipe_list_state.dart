part of 'recipe_list_bloc.dart';

abstract class RecipeListState extends Equatable  {
  const RecipeListState();

  @override
  List<Object> get props => [];
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
