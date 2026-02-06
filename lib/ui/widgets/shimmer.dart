import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Shimmer extends StatelessWidget {
  final double width;
  final double height;
  final double? radius;
  final EdgeInsetsGeometry margin;

  const Shimmer({
    super.key,
    this.width = double.infinity,
    this.height = 20,
    this.radius,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: radius != null ? BorderRadius.circular(radius!) : BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.tertiary.withAlpha(125),
      ),
    ).animate(onComplete: (controller) => controller.repeat()).shimmer(duration: Duration(milliseconds: 1000), colors: [
      Theme.of(context).colorScheme.tertiary,
      Theme.of(context).colorScheme.surface,
      Theme.of(context).colorScheme.tertiary,
    ]);
  }
}
