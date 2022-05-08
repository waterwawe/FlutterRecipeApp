import 'Recipe.dart';

class Hit {
  Recipe recipe;

  Hit({required this.recipe});

  factory Hit.fromJson(json) {
    return Hit(
      recipe: Recipe.fromJson(json["recipe"])
  );
  }
}