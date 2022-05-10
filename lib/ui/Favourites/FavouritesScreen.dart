
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../RecipeList/RecipeList.dart';
import '../RecipeList/recipe_list_bloc.dart';

class FavouritesScreen extends StatelessWidget{

  FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecipeListBloc(),
      child: RecipeList(
          isFavourites: true,
          queryString: ""
      ),
    );
  }
  
}