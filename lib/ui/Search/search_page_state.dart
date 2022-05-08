import 'package:equatable/equatable.dart';
import 'package:flutter_recipe/models/Recipe.dart';
import '../../models/Hit.dart';

class SearchPageState extends Equatable {
  bool isLoading;
  String searchText;
  List<Hit> searchList;

  SearchPageState({
    required this.isLoading,
    required this.searchText,
    required this.searchList,
  });

  factory SearchPageState.initial() {
    return SearchPageState(
      isLoading: false,
      searchText: '',
      searchList: [],
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        searchText,
        searchList,
      ];

  SearchPageState copyWith({
    bool? isLoading,
    String? searchText,
    List<Hit>? searchList,
  }) {
    return SearchPageState(
      isLoading: isLoading ?? this.isLoading,
      searchText: searchText ?? this.searchText,
      searchList: searchList ?? this.searchList,
    );
  }
}
