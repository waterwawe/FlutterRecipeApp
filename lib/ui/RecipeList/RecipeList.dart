import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recipe/ui/RecipeDetails/RecipeDetail.dart';
import 'package:flutter_recipe/ui/RecipeList/recipe_list_bloc.dart';

import '../../models/Recipe.dart';

class RecipeList extends StatefulWidget {
  String queryString;

  RecipeList({Key? key, required this.queryString}) : super(key: key);

  @override
  State<RecipeList> createState() => _RecipeList();
}

class _RecipeList extends State<RecipeList> {
  late RecipeListBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<RecipeListBloc>(context);
    bloc.add(LoadRecipesResults(queryString: widget.queryString));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            "Recipes",
            style: Theme.of(context).textTheme.headline1,

          ),
        ),
        body: BlocBuilder<RecipeListBloc, RecipeListState>(
          builder: (context, state) {
            if (state is RecipeListLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RecipeListLoaded) {
              return Container(
                  child: SafeArea(
                      child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 256,
                  ),
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    ...?state.results.hits?.map((result) {
                      return RecipeCard(
                        recipe: result.recipe,
                      );
                    }).toList()
                  ],
                ),
              )));
            } else if (state is RecipeListError) {
              return const Center(
                child: Text("Error happened"),
              );
            } else {
              return Center(
                child: Container(
                  child: Text("Nothing happaned"),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  Recipe recipe;

  RecipeCard({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => RecipeDetail(recipe: recipe)));
      },
      child: ClipRRect(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: Container(
                  height: 120,
                  foregroundDecoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: recipe.imageUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(2),
                child: Text(
                  recipe.label!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(2),
                child: Text(
                  "Calories: " + (recipe.calories!.toStringAsFixed(2)),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(2),
                child: Text(
                  recipe.timeToMake!.round() != 0
                      ? "Time to make: " +
                          recipe.timeToMake!.round().toString() +
                          " min"
                      : "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
