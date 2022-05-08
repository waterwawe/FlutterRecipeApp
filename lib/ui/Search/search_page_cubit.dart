import 'package:bloc/bloc.dart';
import 'package:flutter_recipe/repositories/RecipesRepository.dart';
import 'package:flutter_recipe/ui/Search/search_page_state.dart';

class SearchPageCubit extends Cubit<SearchPageState> {
  SearchPageCubit() : super(SearchPageState.initial());
  final repo = RecipesRepository();

  void textChange(String text) async {
    emit(state.copyWith(isLoading: true, searchText: text));
    final list = await repo.searchRecipes(text);
    emit(state.copyWith(isLoading: false, searchList: list.hits));
  }
}
