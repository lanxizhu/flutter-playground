// lib/features/home/widgets/home_header.dart
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      floating: true,
      title: Text('我的应用首页'),
      actions: [
        IconButton(onPressed: null, icon: Icon(Icons.notifications_none)),
      ],
    );
  }
}
