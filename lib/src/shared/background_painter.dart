import 'package:flutter/material.dart';
import 'package:watch/src/shared/custom_paints.dart';

class PaintedBackground extends StatelessWidget {
  final Widget child;
  final CustomPainter? painter;
  const PaintedBackground({Key? key, required this.child, this.painter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: painter ?? RedShaderPainter(),
      child: child,
    );
  }
}
