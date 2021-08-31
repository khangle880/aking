import 'package:aking/global/constants/assets_path.dart';
import 'package:aking/views/widgets/simple_rive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchLoading extends StatelessWidget {
  const SearchLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(),
            SimpleRiveWidget(
              rivePath: loadingCatRive,
              simpleAnimation: loadingCatSimpleAnimation,
              width: 150.h,
              height: 150.h,
            ),
            Text("No thing but us",
                style: Theme.of(context).textTheme.subtitle1),
            Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
