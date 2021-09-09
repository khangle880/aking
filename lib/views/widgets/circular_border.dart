import 'dart:math';

import 'package:flutter/material.dart';

class CircularBorder extends StatelessWidget {
  final Color color;
  final Color backgroudColor;
  final double size;
  final double strokeWidth;
  final double backgroundStrokeWidth;
  final Widget? child;
  final int numberDot;
  final double offsetDot;
  final double ratioDot;

  const CircularBorder({
    Key? key,
    this.color = Colors.blue,
    this.size = 70,
    this.strokeWidth = 7.0,
    this.child,
    this.numberDot = 4,
    this.offsetDot = 60,
    this.backgroudColor = Colors.grey,
    this.backgroundStrokeWidth = 1.0,
    this.ratioDot = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          child ?? Container(),
          CustomPaint(
            size: Size(size, size),
            foregroundPainter: MyPainter(
              completeColor: color,
              strokeWidth: strokeWidth,
              numberDot: numberDot,
              offsetDot: offsetDot,
              backgroundColor: backgroudColor,
              backgroundStrokeWidth: backgroundStrokeWidth,
              ratioDot: ratioDot,
            ),
          ),
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final Color lineColor = Colors.transparent;
  final Color completeColor;
  final double strokeWidth;
  final int numberDot;
  final double offsetDot;
  final Color backgroundColor;
  final double backgroundStrokeWidth;
  final double ratioDot;

  MyPainter({
    required this.completeColor,
    required this.strokeWidth,
    required this.numberDot,
    required this.offsetDot,
    required this.backgroundColor,
    required this.backgroundStrokeWidth,
    required this.ratioDot,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final Paint complete = Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final Paint background = Paint()
      ..color = backgroundColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = backgroundStrokeWidth;

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = min(size.width / 2, size.height / 2);
    final percent = (size.width * 0.001) / 2;

    final double arcAngle = 2 * pi * percent * ratioDot;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), 0, 100,
        false, background);

    for (var i = 0; i < numberDot; i++) {
      final init = (pi / 2) * (4 * i / numberDot) - percent * offsetDot;

      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), init,
          arcAngle, false, complete);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
