import 'package:aking/animation/route_animation/bouncy_page_route.dart';
import 'package:aking/routes/wrapper/wrapper.dart';
import 'package:aking/widgets/fade_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:aking/size_config.dart';

const logoRiveDir = "assets/rive/splash.riv";

class SplashContent extends StatefulWidget {
  const SplashContent({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  _SplashContentState createState() => _SplashContentState();
}

class _SplashContentState extends State<SplashContent> {
  Artboard? _artboard;

  @override
  void initState() {
    super.initState();
    loadRive();

    Future.delayed(const Duration(milliseconds: 3500), () {
      Navigator.pushReplacement(context, BouncyPageRoute(widget: Wrapper()));
    });
  }

  Future loadRive() async {
    final bytes = await rootBundle.load(logoRiveDir);
    final RiveFile riveFile = RiveFile.import(bytes);
    setState(() {
      _artboard = riveFile.mainArtboard
        ..addController(SimpleAnimation('Animation 1'));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (_artboard != null)
          SizedBox(
            width: getProportionateScreenWidth(149),
            height: getProportionateScreenHeight(149),
            child: Rive(
              artboard: _artboard ?? Artboard(),
            ),
          ),
        FadeWidget(
          milliseconds: 2500,
          child: Text(widget.text,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: getProportionateScreenWidth(48),
                color: const Color(0xFF010101),
                height: getProportionateScreenHeight(56 / 48),
                shadows: const <Shadow>[
                  Shadow(
                    offset: Offset(0.0, 4.0),
                    blurRadius: 4.0,
                    color: Color.fromARGB(64, 0, 0, 0),
                  ),
                ],
              )),
        )
      ],
    );
  }
}
