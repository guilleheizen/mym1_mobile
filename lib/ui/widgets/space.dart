import 'package:flutter/material.dart';

class Space extends StatelessWidget {
  final Widget child;
  final double bottom;
  final double top;
  final double right;
  final double left;
  final double all;
  final double vertical;
  final double horizontal;
  final MainAxisAlignment alignment;
  final bool visible;
  final bool safeTop;
  final bool safeBottom;

  const Space({
    super.key,
    required this.child,
    this.bottom = 20,
    this.top = 0,
    this.right = 0,
    this.left = 0,
    this.alignment = MainAxisAlignment.start,
    this.all = 0,
    this.vertical = 0,
    this.horizontal = 0,
    this.visible = true,
    this.safeTop = false,
    this.safeBottom = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!visible) {
      return SizedBox.shrink();
    }

    if (safeTop || safeBottom) {
      return SafeArea(
        bottom: safeBottom,
        top: safeTop,
        child: Container(
          margin: _getMargin(),
          child: Row(
            mainAxisAlignment: alignment,
            children: [
              Expanded(
                child: child,
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      margin: _getMargin(),
      child: Row(
        mainAxisAlignment: alignment,
        children: [
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }

  EdgeInsetsGeometry _getMargin() {
    EdgeInsets margin = EdgeInsets.fromLTRB(left, top, right, bottom);

    if (all != 0) {
      margin = EdgeInsets.all(all);
      return margin;
    }

    if (horizontal != 0 && vertical != 0) {
      margin = EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
      return margin;
    }

    if (horizontal != 0) {
      margin = EdgeInsets.symmetric(horizontal: horizontal).copyWith(bottom: bottom, top: top);
      return margin;
    }

    if (vertical != 0) {
      margin = EdgeInsets.symmetric(vertical: vertical).copyWith(right: right, left: left);
      return margin;
    }
    return margin;
  }
}
