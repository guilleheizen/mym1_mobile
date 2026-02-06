import 'package:flutter/material.dart';
import 'package:mym1_mobile/ui/widgets/index.dart';

class ImageLoader extends StatelessWidget {
  final String image;
  const ImageLoader({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Shimmer(
          radius: 0,
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.broken_image);
      },
    );
  }
}
