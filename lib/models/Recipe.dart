import 'dart:convert';

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

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'image': imageUrl,
      'calories': calories,
      'totalTime': timeToMake,
      'cautions': jsonEncode(cautions),
      'ingredientLines': jsonEncode(ingredientLines),
      'cuisineType': jsonEncode(cuisineType),
    };
  }

  factory Recipe.fromJson(json) {
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

  factory Recipe.fromFavourite(json) {

    return Recipe(
        label: json["label"] as String,
        imageUrl: json["image"] as String,
        calories: json["calories"] as double,
        timeToMake: json["totalTime"] as double
        );
  }
}
