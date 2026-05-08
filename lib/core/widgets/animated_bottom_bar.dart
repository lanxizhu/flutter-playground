import 'package:flutter/material.dart';

class AnimatedBottomBar extends StatefulWidget {
  final List<BarItem> barItems;
  final Duration animationDuration;
  final Function onBarTap;
  final BarStyle barStyle;
  final int selectedIndex;

  const AnimatedBottomBar({
    super.key,
    required this.barItems,
    this.animationDuration = const Duration(milliseconds: 500),
    required this.onBarTap,
    required this.barStyle,
    required this.selectedIndex,
  });

  @override
  AnimatedBottomBarState createState() => AnimatedBottomBarState();
}

class AnimatedBottomBarState extends State<AnimatedBottomBar>
    with TickerProviderStateMixin {
  late int selectedBarIndex;

  @override
  void initState() {
    super.initState();
    selectedBarIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 0,
          top: 10.0,
          left: 16.0,
          right: 16.0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _buildBarItems(),
        ),
      ),
    );
  }

  List<Widget> _buildBarItems() {
    List<Widget> barItems = [];
    for (int i = 0; i < widget.barItems.length; i++) {
      BarItem item = widget.barItems[i];
      bool isSelected = selectedBarIndex == i;
      barItems.add(
        InkWell(
          // splashColor: item.color.withOpacity(0.3),
          // highlightColor: item.color.withOpacity(0.1),
          // hoverColor: item.color.withOpacity(0.05),
          splashColor: isSelected
              ? item.color.withAlpha(77)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            setState(() {
              selectedBarIndex = i;
              widget.onBarTap(selectedBarIndex);
            });
          },
          child: AnimatedContainer(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            duration: widget.animationDuration,
            decoration: BoxDecoration(
              color: isSelected ? item.color.withAlpha(38) : Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  isSelected ? item.selectData : item.iconData,
                  color: isSelected
                      ? item.color
                      : ColorScheme.of(context).onSurface.withAlpha(150),
                  size: widget.barStyle.iconSize,
                ),
                AnimatedSize(
                  duration: widget.animationDuration,
                  curve: Curves.easeInOut,
                  child: Text(
                    isSelected ? item.text : "",
                    style: TextStyle(
                      color: item.color,
                      fontWeight: widget.barStyle.fontWeight,
                      fontSize: widget.barStyle.fontSize,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return barItems;
  }
}

class BarStyle {
  final double fontSize, iconSize;
  final FontWeight fontWeight;

  BarStyle({
    this.fontSize = 18.0,
    this.iconSize = 32,
    this.fontWeight = FontWeight.w600,
  });
}

class BarItem {
  String text;
  IconData iconData;
  IconData selectData;
  Color color;

  BarItem({
    required this.text,
    required this.iconData,
    required this.selectData,
    required this.color,
  });
}
