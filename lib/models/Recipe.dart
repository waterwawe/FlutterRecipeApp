class Recipe{
  String? label;
  String? imageUrl;
  double? calories;
  double? timeToMake;
  List<String>? cuisineType;
  List<String>? ingredientLines;
  List<String>? cautions;

  Recipe({
    this.label,
    this.imageUrl,
    this.calories,
    this.timeToMake,
    this.cuisineType,
    this.ingredientLines,
    this.cautions
});

  factory Recipe.fromJson(json) => Recipe(
    label: json["recipe.label"] as String?,
    imageUrl: json["recipe.image"] as String?,
    calories: json["recipe.calories"] as double?,
    timeToMake: json["recipe.totalTime"] as double?,
    cuisineType: json["recipe.cuisineType"] as List<String>?,
    ingredientLines: json["recipe.ingredientLines"] as List<String>?,
    cautions: json["recipe.cautions"] as List<String>?
  );
}