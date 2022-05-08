class Recipe {
  String? label;
  String? imageUrl;
  double? calories;
  double? timeToMake;
  List<String>? cuisineType;
  List<String>? ingredientLines;
  List<String>? cautions;

  Recipe(
      {this.label,
      this.imageUrl,
      this.calories,
      this.timeToMake,
      this.cuisineType,
      this.ingredientLines,
      this.cautions});

  factory Recipe.fromJson(json) {
    String label = json["label"] as String;
    String imageUrl = json["image"] as String;

    var cuisineTypeArray = json['cuisineType']; // array is now List<dynamic>
    List<String> cuisineTypes = List<String>.from(cuisineTypeArray);

    var ingredientLinesArray = json['ingredientLines']; // array is now List<dynamic>
    List<String> ingredientLines = List<String>.from(ingredientLinesArray);

    var cautionsArray = json['cautions']; // array is now List<dynamic>
    List<String> cautions = List<String>.from(cautionsArray);


    return Recipe(
        label: json["label"] as String,
        imageUrl: json["image"] as String,
        calories: json["calories"] as double,
        timeToMake: json["totalTime"] as double,
        cuisineType: cuisineTypes,
        ingredientLines: ingredientLines,
        cautions: cautions);
  }
}
