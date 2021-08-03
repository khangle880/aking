// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:

class WaveBottom extends StatelessWidget {
  const WaveBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class FrontClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double _xScaling = size.width / 356;
    final double _yScaling = size.height / 256;
    path.lineTo(316.592 * _xScaling, 23.1849 * _yScaling);
    path.cubicTo(
      316.592 * _xScaling,
      23.1849 * _yScaling,
      213.715 * _xScaling,
      52.2375 * _yScaling,
      125.267 * _xScaling,
      15.8479 * _yScaling,
    );
    path.cubicTo(
      36.8191 * _xScaling,
      -20.5418 * _yScaling,
      -2.03638 * _xScaling,
      19.1891 * _yScaling,
      -28.8378 * _xScaling,
      4.59582 * _yScaling,
    );
    path.cubicTo(
      -55.6392 * _xScaling,
      -9.99745 * _yScaling,
      -31.72 * _xScaling,
      287.696 * _yScaling,
      -31.72 * _xScaling,
      287.696 * _yScaling,
    );
    path.cubicTo(
      -31.72 * _xScaling,
      287.696 * _yScaling,
      253.652 * _xScaling,
      330 * _yScaling,
      253.652 * _xScaling,
      330 * _yScaling,
    );
    path.cubicTo(
      253.652 * _xScaling,
      330 * _yScaling,
      338.88 * _xScaling,
      287.696 * _yScaling,
      338.88 * _xScaling,
      287.696 * _yScaling,
    );
    path.cubicTo(
      338.88 * _xScaling,
      287.696 * _yScaling,
      356 * _xScaling,
      117.232 * _yScaling,
      356 * _xScaling,
      117.232 * _yScaling,
    );
    path.cubicTo(
      356 * _xScaling,
      117.232 * _yScaling,
      316.592 * _xScaling,
      23.1849 * _yScaling,
      316.592 * _xScaling,
      23.1849 * _yScaling,
    );
    path.cubicTo(
      316.592 * _xScaling,
      23.1849 * _yScaling,
      316.592 * _xScaling,
      23.1849 * _yScaling,
      316.592 * _xScaling,
      23.1849 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class BackClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double _xScaling = size.width / 375;
    final double _yScaling = size.height / 270;
    path.lineTo(0.259697 * _xScaling, 25.4332 * _yScaling);
    path.cubicTo(
      0.259697 * _xScaling,
      25.4332 * _yScaling,
      113.192 * _xScaling,
      57.303 * _yScaling,
      210.286 * _xScaling,
      17.3846 * _yScaling,
    );
    path.cubicTo(
      307.379 * _xScaling,
      -22.5337 * _yScaling,
      350.032 * _xScaling,
      21.0499 * _yScaling,
      379.454 * _xScaling,
      5.04148 * _yScaling,
    );
    path.cubicTo(
      408.875 * _xScaling,
      -10.9669 * _yScaling,
      382.617 * _xScaling,
      315.594 * _yScaling,
      382.617 * _xScaling,
      315.594 * _yScaling,
    );
    path.cubicTo(
      382.617 * _xScaling,
      315.594 * _yScaling,
      69.352 * _xScaling,
      362 * _yScaling,
      69.352 * _xScaling,
      362 * _yScaling,
    );
    path.cubicTo(
      69.352 * _xScaling,
      362 * _yScaling,
      -24.2062 * _xScaling,
      315.594 * _yScaling,
      -24.2062 * _xScaling,
      315.594 * _yScaling,
    );
    path.cubicTo(
      -24.2062 * _xScaling,
      315.594 * _yScaling,
      -43 * _xScaling,
      128.6 * _yScaling,
      -43 * _xScaling,
      128.6 * _yScaling,
    );
    path.cubicTo(
      -43 * _xScaling,
      128.6 * _yScaling,
      0.259697 * _xScaling,
      25.4332 * _yScaling,
      0.259697 * _xScaling,
      25.4332 * _yScaling,
    );
    path.cubicTo(
      0.259697 * _xScaling,
      25.4332 * _yScaling,
      0.259697 * _xScaling,
      25.4332 * _yScaling,
      0.259697 * _xScaling,
      25.4332 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
