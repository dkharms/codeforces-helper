import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  final Color firstColor;
  final Color secondColor;
  final double canvasHeight;

  WavePainter(
      {required this.firstColor,
      required this.secondColor,
      required this.canvasHeight});

  @override
  void paint(Canvas canvas, Size size) {
    Paint wavePaint = Paint()
      ..shader = LinearGradient(colors: [
        firstColor.withOpacity(0.25),
        secondColor.withOpacity(0.25)
      ]).createShader(Rect.fromLTRB(0, 0, size.width, 0.5 * canvasHeight));

    final w = size.width;
    final h = canvasHeight;

    final path = Path()
      ..moveTo(0, 0.5 * h)
      ..quadraticBezierTo(w / 4, h / 6, w / 2, h / 2)
      ..quadraticBezierTo(3 * w / 4, 0.8 * h, w, 0.25 * h)
      ..lineTo(w, 0)
      ..lineTo(0, 0)
      ..close();

    canvas.drawPath(path, wavePaint);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(WavePainter oldDelegate) => false;
}
