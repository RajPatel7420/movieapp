import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp/controllers/home_controller.dart';
import 'package:movieapp/view/home_view.dart';
import 'package:movieapp/widget/bottom_navigation_bar/bottom_bar.dart';

import '../../view/movie_search_view.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({
    Key? key,
    this.selectedIndex = 0,
  }) : super(key: key);
  final int selectedIndex;

  @override
  _BottomNavigationPageState createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _selectedIndex = 0;
  final controller = Get.put(HomeController());

  final GlobalKey<BottomBarState> _bottomBarKey = GlobalKey<BottomBarState>();

  final List _pages = [
    const HomeView(),
    const MovieSearchView(),
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedIndex = widget.selectedIndex;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const bottomToolBarHeight = kToolbarHeight + 16;
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomBar(
        key: _bottomBarKey,
        bottomToolBarHeight: bottomToolBarHeight,
        onBottomTabSelected: (tab) {
          _onItemTapped(tab.index);
        },
      ),
    );
  }
}
