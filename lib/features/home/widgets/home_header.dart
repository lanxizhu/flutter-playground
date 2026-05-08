// lib/features/home/widgets/home_header.dart
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      stretch: true,
      stretchTriggerOffset: 200.0,
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'SliverAppBar',
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        titlePadding: const EdgeInsetsDirectional.only(start: 16, bottom: 16),
        centerTitle: false,
        background: Stack(
          fit: StackFit.expand,
          children: [Image.asset('assets/header_bg.jpg', fit: BoxFit.cover)],
        ),
        collapseMode: CollapseMode.none,
      ),
      actions: [
        IconButton(onPressed: null, icon: Icon(Icons.notifications_none)),
      ],
    );
  }
}
