import 'package:flutter/material.dart';
import 'package:playground/app/controllers/theme_controller.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key, required this.themeController});

  final ThemeController themeController;

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        // 渐变背景
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.cyan[isDark ? 800 : 300]!,
            Theme.of(context).colorScheme.surface,
          ],
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

                Switch(
                  value: isDark,
                  onChanged: (bool value) {
                    if (value) {
                      widget.themeController.useDarkMode();
                    } else {
                      widget.themeController.useLightMode();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
