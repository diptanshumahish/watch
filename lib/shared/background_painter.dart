import 'package:flutter/material.dart';

class PaintedBackground extends StatelessWidget {
  final Widget child;
  const PaintedBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RedShaderPainter(),
      child: child,
    );
  }
}

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
