import 'package:flutter/material.dart';

class BannerSwiper extends StatefulWidget {
  const BannerSwiper({super.key});

  @override
  State<BannerSwiper> createState() => _BannerSwiperState();
}

class _BannerSwiperState extends State<BannerSwiper> {
  late final PageController _controller;

  int _current = 0;

  final int _initialPage = 10000;

  final List<String> images = [
    'assets/banner-1.jpg',
    'assets/banner-2.jpg',
    'assets/banner-3.jpg',
    'assets/banner-4.jpg',
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: _initialPage,
      viewportFraction: 0.92,
    );

    _current = _initialPage % images.length;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _controller,
            // itemCount: images.length,
            onPageChanged: (index) {
              setState(() => _current = index % images.length);
            },
            itemBuilder: (context, index) {
              final realIndex = index % images.length;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    images[realIndex],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(images.length, (index) {
            final active = index % images.length == _current;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: active ? 16 : 6,
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                color: active
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.outlineVariant,
              ),
            );
          }),
        ),
      ],
    );
  }
}
