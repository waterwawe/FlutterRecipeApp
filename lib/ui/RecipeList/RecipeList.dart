import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recipe/ui/RecipeDetails/RecipeDetail.dart';
import 'package:flutter_recipe/ui/RecipeList/recipe_list_bloc.dart';

import '../../models/Recipe.dart';

typedef ButtonCallback = void Function(Recipe);

class RecipeList extends StatefulWidget {
  String queryString;
  bool isFavourites;

  RecipeList({Key? key, required this.isFavourites, required this.queryString})
      : super(key: key);

  @override
  State<RecipeList> createState() => _RecipeList();
}

class _RecipeList extends State<RecipeList> {
  late RecipeListBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<RecipeListBloc>(context);
    if (!widget.isFavourites) {
      bloc.add(LoadRecipesResults(queryString: widget.queryString));
    } else {
      bloc.add(LoadFavouriteRecipes());
    }

    super.initState();
  }

  refreshFavourites() {
    bloc.add(LoadFavouriteRecipes());
  }

  addToFavourites(Recipe recipe) {
    bloc = BlocProvider.of<RecipeListBloc>(context);
    bloc.add(AddToFavourites(recipe: recipe));
  }

  removeFromFavourites(Recipe recipe) {
    bloc = BlocProvider.of<RecipeListBloc>(context);
    bloc.add(RemoveFromFavourites(recipe: recipe));
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
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.isFavourites ? "Favourite Recipes" : "Recipes",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  if (widget.isFavourites)
                      ElevatedButton(
                          onPressed: () {
                            refreshFavourites();
                          },
                          child: Icon(CupertinoIcons.refresh))
                  else
                    Text("")
                ])),
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
                    mainAxisExtent: 330,
                  ),
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    ...?state.results.hits!.map((result) {
                      return RecipeCard(
                        recipe: result.recipe,
                        buttonText: widget.isFavourites
                            ? "Remove favourite"
                            : "Add favourite",
                        buttonAction: widget.isFavourites
                            ? removeFromFavourites
                            : addToFavourites,
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
  ButtonCallback buttonAction;
  String buttonText;

  RecipeCard(
      {Key? key,
      required this.recipe,
      required this.buttonAction,
      required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (buttonText == "Add favourite") {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => RecipeDetail(recipe: recipe)));
        }
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
              Container(
                padding: const EdgeInsets.all(2),
                child: ElevatedButton(
                  onPressed: () {
                    buttonAction(recipe);
                  },
                  child: Text(
                    buttonText,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
