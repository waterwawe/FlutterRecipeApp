import 'Recipe.dart';

class RecipeResults{
  int? from;
  int? to;
  int? count;
  List<Recipe>? hits;

  RecipeResults({
    this.from,
    this.to,
    this.count,
    this.hits
  });

  factory RecipeResults.fromJson(json) => RecipeResults(
      from: json["from"] as int?,
      to: json["to"] as int?,
      count: json["count"] as int?,
      hits: json["hits"] as List<Recipe>?,
  );
}