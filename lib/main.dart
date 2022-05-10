import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recipe/models/Recipe.dart';
import 'package:flutter_recipe/ui/Navigation/TabSwitcher.dart';
import 'package:flutter_recipe/ui/Search/SearchPage.dart';
import 'package:flutter_recipe/ui/Search/search_page_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Satoshi',
        primarySwatch: Colors.blue,
        primaryColor: Colors.blueAccent,
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontFamily: 'Telma',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
      ),
      home:  const TabSwitcher()
      );
  }
}
