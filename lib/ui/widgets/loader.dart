import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

enum ColorStyle { system, light, dark }

class Loader extends StatelessWidget {
  final double size;
  final ColorStyle colorStyle;
  const Loader({super.key, this.size = 100, this.colorStyle = ColorStyle.system});

  @override
  Widget build(BuildContext context) {
    final darkIcon = Image.asset('assets/images/dark_logo.png');
    final lightIcon = Image.asset('assets/images/light_logo.png');
    final systemIcon = Theme.of(context).brightness == Brightness.dark ? darkIcon : lightIcon;

    return Center(
      child: SizedBox(
        height: size,
        child: colorStyle == ColorStyle.system
            ? systemIcon
            : colorStyle == ColorStyle.dark
                ? darkIcon
                : lightIcon,
      )
          .animate(
            onComplete: (controller) => controller.repeat(),
          )
          .move(
            begin: const Offset(0, -40),
            end: Offset.zero,
            duration: 300.ms,
            curve: Curves.easeOut,
          )
          .fade(
            begin: 0,
            end: 1,
            duration: 300.ms,
          )
          .then(delay: 1000.ms) 
          .move(
            begin: Offset.zero,
            end: const Offset(0, 40),
            duration: 300.ms,
            curve: Curves.easeIn,
          )
          .fade(
            begin: 1,
            end: 0,
            duration: 300.ms,
          ),
    );
  }
}
