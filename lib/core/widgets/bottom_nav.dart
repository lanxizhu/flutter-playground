import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:playground/core/widgets/animated_bottom_bar.dart';

class BottomBarNavigation extends StatefulWidget {
  BottomBarNavigation({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  final int currentIndex;

  final ValueChanged<int>? onDestinationSelected;

  final List<BarItem> barItems = [
    BarItem(
      text: "Home",
      iconData: Icons.home_outlined,
      selectData: Icons.home,
      color: Colors.indigo,
    ),
    BarItem(
      text: "Likes",
      iconData: Icons.favorite_border,
      selectData: Icons.favorite,
      color: Colors.pinkAccent,
    ),
    BarItem(
      text: "Search",
      iconData: Icons.search,
      selectData: Icons.search,
      color: Colors.yellow.shade900,
    ),
    BarItem(
      text: "Profile",
      iconData: Icons.person_outline,
      selectData: Icons.person,
      color: Colors.teal,
    ),
  ];

  @override
  BottomBarNavigationState createState() => BottomBarNavigationState();
}

class BottomBarNavigationState extends State<BottomBarNavigation> {
  late int selectedBarIndex;

  @override
  void initState() {
    super.initState();
    selectedBarIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 50),
        child: Container(
          decoration: BoxDecoration(
            // color: ColorScheme.of(context).surface.withValues(alpha: 0.3),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ColorScheme.of(context).surface.withValues(alpha: 0),
                ColorScheme.of(context).surface.withValues(alpha: 0.45),
                ColorScheme.of(context).surface,
              ],
            ),
          ),
          child: Container(
            color: Colors.transparent,
            child: SafeArea(
              maintainBottomViewPadding: false,
              bottom: true,

              child: AnimatedBottomBar(
                barItems: widget.barItems,
                animationDuration: const Duration(milliseconds: 150),
                barStyle: BarStyle(fontSize: 20.0, iconSize: 30.0),
                selectedIndex: selectedBarIndex,
                onBarTap: (index) {
                  setState(() {
                    widget.onDestinationSelected?.call(index);
                    selectedBarIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
