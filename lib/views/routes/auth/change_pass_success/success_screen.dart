import 'package:aking/global/constants/assets_path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const description = '''
You have succesfully change password.
Please use your new passwords when
logging in.''';

    Future.delayed(const Duration(milliseconds: 4000), () {
      Navigator.pop(context);
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 170.h,
            width: double.infinity,
          ),
          SvgPicture.asset(
            AssetPathConstants. successfulSvgImage,
            width: 162.w,
            height: 170.h,
          ),
          SizedBox(
            height: 40.h,
          ),
          Text(
            'Succesful',
            style: textTheme.headline4,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            description,
            style: textTheme.button,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
