import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp/controllers/home_controller.dart';
import 'widget/bottom_bar_item.dart';

enum BottomTab { home, search }

typedef OnBottomTabSelected = Function(BottomTab);

class BottomBar extends StatefulWidget {
  final double bottomToolBarHeight;
  final OnBottomTabSelected onBottomTabSelected;

  const BottomBar({
    Key? key,
    required this.bottomToolBarHeight,
    required this.onBottomTabSelected,
  }) : super(key: key);

  @override
  State<BottomBar> createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> {
  BottomTab activeTab = BottomTab.home;
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: widget.bottomToolBarHeight,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xff16275A), Color(0xff1E3377)],
              tileMode: TileMode.mirror,
            ),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BottomBarItem(
              activeTab: activeTab,
              tab: BottomTab.home,
              title: 'Movie',
              icon: Icon(
                Icons.movie,
                color: activeTab == BottomTab.home
                    ? const Color(0xffF5F9FF)
                    : const Color(0xff94A3B8),
              ),
              onTap: () {
                // homeController.getUserData();
                _onTabClick(BottomTab.home);
              },
            ),
            BottomBarItem(
              activeTab: activeTab,
              tab: BottomTab.search,
              title: 'Search',
              icon: Icon(
                Icons.search,
                color: activeTab == BottomTab.search
                    ? const Color(0xffF5F9FF)
                    : const Color(0xff94A3B8),
              ),
              onTap: () {
                _onTabClick(BottomTab.search);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onTabClick(BottomTab tab) {
    widget.onBottomTabSelected(tab);
    activeTab = tab;
  }
}
