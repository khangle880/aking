import 'package:aking/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:aking/widgets/rounded_button.dart';
import 'package:aking/constants.dart';
import 'package:aking/size_config.dart';
import 'walkthrough_content.dart';
import 'wave.dart';

class WalkthroughBody extends StatefulWidget {
  const WalkthroughBody({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<WalkthroughBody> {
  final List<Map<String, String>> _walkthroughData = [
    {
      "title": "Welcome to aking",
      "description": "Whats going to happen tomorrow?",
      "image": "assets/images/walkthrough1.svg",
      "wave_color": "#F96060"
    },
    {
      "title": "Work happens",
      "description": "Get notified when work happens.",
      "image": "assets/images/walkthrough2.svg",
      "wave_color": "#6074F9"
    },
    {
      "title": "Tasks and assign",
      "description": "Task and assign them to colleagues.",
      "image": "assets/images/walkthrough3.svg",
      "wave_color": "#8560F9"
    },
  ];

  int _currentPage = 0;
  late Animatable<Color?> _background;
  late PageController _pageController;
  void _initialize() {
    _background = TweenSequence<Color?>([
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: const Color(0xFFF96060),
          end: const Color(0xFF6074F9),
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: const Color(0xFF6074F9),
          end: const Color(0xFF8560F9),
        ),
      ),
    ]);
    _pageController = PageController();
  }

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _pageController,
        builder: (context, child) {
          final _color =
              _pageController.hasClients ? _pageController.page! / 2.0 : .0;

          return Column(
            children: <Widget>[
              SizedBox(
                height: getProportionateScreenHeight(490),
                width: double.infinity,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (value) {
                    setState(() {
                      _currentPage = value;
                    });
                  },
                  itemCount: _walkthroughData.length,
                  itemBuilder: (context, index) => WalkthroughContent(
                      image: _walkthroughData[_currentPage]["image"]!,
                      title: _walkthroughData[_currentPage]["title"]!,
                      description: _walkthroughData[_currentPage]
                          ["description"]!),
                ),
              ),
              Padding(
                  padding: EdgeInsets.zero,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_walkthroughData.length,
                          (index) => buildDot(index: index)))),
              SizedBox(height: getProportionateScreenHeight(30)),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: ClipPath(
                          clipper: FrontClipper(),
                          child: Container(
                            color: _background
                                .evaluate(AlwaysStoppedAnimation(_color))!
                                .withOpacity(0.2),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.zero,
                        child: ClipPath(
                          clipper: BackClipper(),
                          child: Container(
                            color: _background
                                .evaluate(AlwaysStoppedAnimation(_color)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: getProportionateScreenWidth(40),
                          left: getProportionateScreenWidth(40),
                        ),
                        child: Column(
                          children: [
                            const Spacer(
                              flex: 4,
                            ),
                            RoundedButton(
                              backgroundColor: hexToColor("#FFFFFF"),
                              press: () {
                                Navigator.pushNamed(
                                    context, Routes.signInRoute);
                              },
                              text: "Get Started",
                              textColor: hexToColor("#313131"),
                            ),
                            const Spacer(),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, Routes.signInRoute);
                                },
                                child: Text("Log In",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            getProportionateScreenHeight(18),
                                        height: getProportionateScreenHeight(
                                            22 / 18),
                                        fontWeight: FontWeight.bold))),
                            const Spacer(
                              flex: 3,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        });
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
        duration: kAnimationDuration,
        margin: const EdgeInsets.only(right: 5),
        height: 6,
        width: index == _currentPage ? 20 : 6,
        decoration: BoxDecoration(
          color: index == _currentPage
              ? hexToColor(_walkthroughData[_currentPage]["wave_color"]!)
              : const Color(0xFFD8D8D8),
          borderRadius: BorderRadius.circular(3),
        ));
  }
}
