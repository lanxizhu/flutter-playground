import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  late final Brightness brightness;
  late bool isDark;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    brightness = Theme.of(context).brightness;
    isDark = brightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // 渐变背景
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.cyan[300]!, Theme.of(context).colorScheme.surface],
        ),
        // 或者图片背景
        // image: DecorationImage(
        //   image: AssetImage("assets/background.png"),
        //   fit: BoxFit.cover,
        // ),
      ),
      child: Stack(
        children: [
          // AppBar(
          //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          //   title: Text('Welcome to the App!'),
          // ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Profile Page',
                  style: TextTheme.of(context).headlineLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
