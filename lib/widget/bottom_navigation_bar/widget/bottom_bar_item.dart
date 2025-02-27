import 'package:flutter/material.dart';
import 'package:movieapp/widget/bottom_navigation_bar/bottom_bar.dart';

class BottomBarItem extends StatelessWidget {
  const BottomBarItem({
    Key? key,
    required this.activeTab,
    required this.tab,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final BottomTab activeTab;
  final BottomTab tab;
  final String title;
  final Icon icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 24,
                child: icon,
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                title,
                style: activeTab == tab
                    ? const TextStyle(
                        color: Color(0xffF5F9FF),
                      )
                    : const TextStyle(
                        color: Color(0xff94A3B8),
                      ),
              ),
              const SizedBox(
                height: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
