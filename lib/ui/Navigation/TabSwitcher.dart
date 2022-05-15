import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recipe/ui/Search/SearchPage.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../Favourites/FavouritesScreen.dart';

class TabSwitcher extends StatefulWidget {
  const TabSwitcher({Key? key}) : super(key: key);

  @override
  _TabSwitcherState createState() => _TabSwitcherState();
}

class _TabSwitcherState extends State<TabSwitcher> {
  late PersistentTabController _controller;

  final List<Widget> _widgetOptions = <Widget>[
    const SearchPage(),
    FavouritesScreen(),
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey.shade600,
        iconSize: 20,
        icon: const Icon(
          CupertinoIcons.search,
        ),
        activeColorPrimary: Colors.blueAccent,
        title: ("Search"),
      ),
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey.shade600,
        icon: const Icon(
          CupertinoIcons.heart_fill,
        ),
        iconSize: 20,
        activeColorPrimary: Colors.blueAccent,
        title: ("Favorites"),
      )
    ];
  }

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PersistentTabView(
        this.context,
        controller: _controller,
        screens: _widgetOptions,
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        hideNavigationBarWhenKeyboardShows: true,
        popAllScreensOnTapOfSelectedTab: true,
        navBarStyle: NavBarStyle.style6,
      ),
    );
  }
}