import 'package:aking/global/constants/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:aking/logic/utils/extensions/logic_extensions.dart';
import 'package:flutter_svg/svg.dart';

class DescriptionRow extends StatelessWidget {
  const DescriptionRow({
    Key? key,
    required this.description,
  }) : super(key: key);
  final String? description;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 44.h,
          height: 44.h,
          child: Column(
            children: [
              SvgPicture.asset(
                AssetPathConstants.noteIcon,
                width: 21.h,
                height: 21.h,
              ),
            ],
          ),
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Description",
              overflow: TextOverflow.ellipsis,
              style: textTheme.button!.toBlurColor(),
            ),
            SizedBox(height: 2.h),
            Text(
              (description == null || description == "")
                  ? 'No Description'
                  : description!,
              overflow: TextOverflow.ellipsis,
              style: textTheme.subtitle1!.copyWith(fontSize: 16.sp),
            ),
          ],
        ),
      ],
    );
  }
}
