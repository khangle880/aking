import 'dart:collection';

import 'package:aking/global/constants/app_constants.dart';
import 'package:aking/logic/models/walkthrough.dart';
import 'package:aking/logic/provider/walkthrough_cache.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:aking/routing/app_routes.dart';
import 'package:aking/routing/routes.dart';
import 'package:aking/views/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'walkthrough_content.dart';
import 'wave.dart';

class WalkthroughBody extends StatefulWidget {
  const WalkthroughBody({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<WalkthroughBody> {
  late UnmodifiableListView<Walkthrough> _walkthroughData;

  int _currentPage = 0;
  late Animatable<Color?> _background;
  late PageController _pageController;
  void _initialize() {
    _walkthroughData = WalkthroughCache().list;
    _background = TweenSequence<Color?>([
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: ExpandedColor.fromHex(_walkthroughData[0].waveColor),
          end: ExpandedColor.fromHex(_walkthroughData[1].waveColor),
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: ExpandedColor.fromHex(_walkthroughData[1].waveColor),
          end: ExpandedColor.fromHex(_walkthroughData[2].waveColor),
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
                height: 490.h,
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
                      image: _walkthroughData[_currentPage].imagePath,
                      title: _walkthroughData[_currentPage].title,
                      description: _walkthroughData[_currentPage].description),
                ),
              ),
              Padding(
                  padding: EdgeInsets.zero,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_walkthroughData.length,
                          (index) => buildDot(index: index)))),
              SizedBox(height: 30.h),
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
                        padding: EdgeInsets.symmetric(horizontal: 40.w),
                        child: Column(
                          children: [
                            const Spacer(
                              flex: 4,
                            ),
                            RoundedButton(
                              onPressed: () {
                                AppRoutes.appNav.currentState!
                                    .pushNamed(AppRouteNames.signInRoute);
                              },
                              backgroundColor: Colors.white,
                              text: "Get Started",
                              textColor: ExpandedColor.fromHex("#313131"),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                AppRoutes.appNav.currentState!
                                    .pushNamed(AppRouteNames.signInRoute);
                              },
                              child: Text(
                                "Log In",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color:
                                            ExpandedColor.fromHex("#FFFFFF")),
                              ),
                            ),
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
        duration: AppConstants.kAnimationDuration,
        margin: const EdgeInsets.only(right: 5),
        height: 6,
        width: index == _currentPage ? 20 : 6,
        decoration: BoxDecoration(
          color: index == _currentPage
              ? ExpandedColor.fromHex(_walkthroughData[_currentPage].waveColor)
              : const Color(0xFFD8D8D8),
          borderRadius: BorderRadius.circular(3.r),
        ));
  }
}
