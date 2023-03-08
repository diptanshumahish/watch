import 'package:flutter/material.dart';

class RedShaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const rect = Rect.fromLTRB(-150, -150, 270, 270);
    final paint = Paint();
    canvas.drawRect(Offset.zero & size, paint);
    paint.shader = RadialGradient(
      colors: [
        const Color(0xFFF41521).withOpacity(0.53),
        const Color(0xFFEE1520).withOpacity(0.20),
      ],
      center: const Alignment(0.15, 0),
    ).createShader(rect);
    paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 62);
    canvas.drawCircle(rect.center, rect.width / 2, paint);
  }

  @override
  bool shouldRepaint(RedShaderPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(RedShaderPainter oldDelegate) => false;
}

class VariableColorPainter extends CustomPainter {
  final List<Color> colors;

  VariableColorPainter(this.colors);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, size.height - 300, size.width, 600);
    final paint = Paint()
      ..shader = RadialGradient(
        colors: colors,
      ).createShader(rect)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 40);
    canvas.drawRect(rect, paint);
    canvas.drawCircle(rect.center, rect.width, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(CustomPainter oldDelegate) => false;
}
