import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recipe/ui/RecipeList/recipe_list_bloc.dart';
import 'package:flutter_recipe/ui/Search/search_page_cubit.dart';
import 'package:flutter_recipe/ui/Search/search_page_state.dart';

import '../RecipeList/RecipeList.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchPageCubit, SearchPageState>(
        builder: (context, state) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(12),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Search Recipes..",
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search, color: Colors.blueAccent),
                        onPressed: () {},
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 20),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          style: BorderStyle.solid,
                          color: Theme.of(context).primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            style: BorderStyle.solid,
                            color: Colors.black.withOpacity(.5),
                          ),
                          borderRadius: BorderRadius.circular(15))),
                  onSubmitted: (v) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => RecipeListBloc(),
                          child: RecipeList(
                            isFavourites: false,
                            queryString: v
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          body: SafeArea(
              child: state.isLoading
                      ? const Center(child: CircularProgressIndicator()) : Spacer()
          ),
        ),
      );
    });
  }
}
