import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class SimpleRiveWidget extends StatefulWidget {
  const SimpleRiveWidget(
      {Key? key,
      required this.rivePath,
      required this.width,
      required this.height,
      required this.simpleAnimation})
      : super(key: key);
  final String rivePath;
  final String simpleAnimation;
  final double width;
  final double height;

  @override
  _SimpleRiveWidgetState createState() => _SimpleRiveWidgetState();
}

class _SimpleRiveWidgetState extends State<SimpleRiveWidget> {
  Artboard? _artboard;
  @override
  void initState() {
    super.initState();
    loadRive();
  }

  Future loadRive() async {
    final bytes = await rootBundle.load(widget.rivePath);
    final RiveFile riveFile = RiveFile.import(bytes);
    setState(() {
      _artboard = riveFile.mainArtboard
        ..addController(SimpleAnimation(widget.simpleAnimation));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: (_artboard != null)
          ? Rive(
              artboard: _artboard ?? Artboard(),
            )
          : Container(),
    );
  }
}
