import 'package:flutter/material.dart';

class CustomHero extends StatelessWidget {
  final Object tag;
  final Widget child;
  final bool transitionOnUserGestures;
  final Tween<Rect?> Function(Rect?, Rect?)? createRectTween;
  final Widget Function(BuildContext, Size, Widget)? placeholderBuilder;
  const CustomHero({
    Key? key,
    required this.tag,
    required this.child,
    this.createRectTween,
    this.placeholderBuilder,
    this.transitionOnUserGestures = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      transitionOnUserGestures: transitionOnUserGestures,
      createRectTween: createRectTween,
      placeholderBuilder: placeholderBuilder,
      child: Material(
        type: MaterialType.transparency,
        child: child,
      ),
    );
  }
}
