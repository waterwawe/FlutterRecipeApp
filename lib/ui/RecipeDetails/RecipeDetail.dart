import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../models/Recipe.dart';

class RecipeDetail extends StatelessWidget {
  Recipe recipe;

  RecipeDetail({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          recipe.label!,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(-2, -2),
                    blurRadius: 12,
                    color: Color.fromRGBO(0, 0, 0, 0.05),
                  ),
                  BoxShadow(
                    offset: Offset(2, 2),
                    blurRadius: 5,
                    color: Color.fromRGBO(0, 0, 0, 0.10),
                  )
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        Text(recipe.timeToMake!.round().toString() + " min",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                        Text(
                          "to make",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 2,
                    color: Theme.of(context).primaryColor,
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        Text(recipe.cuisineType?[0] ?? "",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                        Text(
                          "cuisine type",
                          style: TextStyle(
                              fontSize: 17, color: Colors.grey.shade600),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 2,
                    color: Theme.of(context).primaryColor,
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        Text(recipe.calories!.toStringAsFixed(2),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                        Text("calories",
                            style: TextStyle(
                                fontSize: 17, color: Colors.grey.shade600))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: recipe.imageUrl!,
                fit: BoxFit.cover,
              )),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(-2, -2),
                    blurRadius: 12,
                    color: Color.fromRGBO(0, 0, 0, 0.05),
                  ),
                  BoxShadow(
                    offset: Offset(2, 2),
                    blurRadius: 5,
                    color: Color.fromRGBO(0, 0, 0, 0.10),
                  )
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(8),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Text(
                    "Ingredients:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                if (recipe.ingredientLines!.isNotEmpty)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...?recipe.ingredientLines?.map((line) {
                        return Text(line, style: TextStyle(fontSize: 15));
                      }).toList()
                    ],
                  ),
                if (recipe.cautions != null) const SizedBox(height: 19),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Cautions:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Column(
                        children: [
                          ...?recipe.cautions?.map((line) {
                            return Text(line,
                                style: TextStyle(
                                  fontSize: 15,
                                ));
                          }).toList()
                        ],
                      ),
                    ],
                  ),
                )
              ]),
            ),
          )
        ]),
      ),
    ));
  }
}
