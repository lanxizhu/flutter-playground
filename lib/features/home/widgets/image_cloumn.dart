import 'package:flutter/material.dart';

class ImageGrid extends StatelessWidget {
  const ImageGrid({super.key});

  @override
  Widget build(BuildContext context) {
    const imageProvider = AssetImage('assets/img-1.jpg');

    const borderRadius = BorderRadius.all(Radius.circular(16));

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: SplitImage(
          image: imageProvider,
          width: MediaQuery.of(context).size.width - 32,
          height: 240,
          gap: 4,
          column: 3,
          row: 3,
        ),
      ),
    );
  }
}

class SplitImage extends StatelessWidget {
  final ImageProvider image;
  final double width;
  final double height;
  final double gap;
  final int column;
  final int row;

  const SplitImage({
    super.key,
    required this.image,
    required this.width,
    required this.height,
    this.gap = 0,
    this.column = 2,
    this.row = 2,
  });

  @override
  Widget build(BuildContext context) {
    final tileWidth = (width - gap * (column - 1)) / column;
    final tileHeight = (height - gap * (row - 1)) / row;

    return SizedBox(
      width: width,
      height: height,
      child: Wrap(
        spacing: gap,
        runSpacing: gap,
        children: List.generate(row * column, (index) {
          final x = index % column;
          final y = index ~/ column;

          return _ImagePart(
            image: image,
            totalWidth: width,
            totalHeight: height,
            tileWidth: tileWidth,
            tileHeight: tileHeight,
            offsetX: -x * tileWidth,
            offsetY: -y * tileHeight,
          );
        }),
      ),
    );
  }
}

class _ImagePart extends StatelessWidget {
  final ImageProvider image;
  final double totalWidth;
  final double totalHeight;
  final double tileWidth;
  final double tileHeight;
  final double offsetX;
  final double offsetY;

  const _ImagePart({
    required this.image,
    required this.totalWidth,
    required this.totalHeight,
    required this.tileWidth,
    required this.tileHeight,
    required this.offsetX,
    required this.offsetY,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: tileWidth,
      height: tileHeight,
      child: ClipRect(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: offsetX,
              top: offsetY,
              child: Image(
                image: image,
                width: totalWidth,
                height: totalHeight,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
