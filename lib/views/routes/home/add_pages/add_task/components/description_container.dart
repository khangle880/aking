import 'package:aking/global/constants/assets_path.dart';
import 'package:aking/logic/provider/add_task.dart';
import 'package:aking/logic/utils/modules/color_module.dart';
import 'package:aking/views/utils/extensions/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DescriptionContainer extends StatelessWidget {
  const DescriptionContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: textTheme.bodyText1!
                .copyWith(fontSize: 16.sp, color: hexToColor('#9E9E9E')),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              border: Border.all(
                color: hexToColor("#EAEAEA"),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: TextField(
                    maxLines: 3,
                    decoration: InputDecoration().toNoneBorder(),
                    onChanged:
                        context.read<AddTaskProvider>().changeDescription,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  color: hexToColor("#F8F8F8"),
                  height: 48.w,
                  child: SvgPicture.asset(attachIcon),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
