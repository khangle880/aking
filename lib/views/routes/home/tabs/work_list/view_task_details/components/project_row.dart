import 'package:aking/global/constants/assets_path.dart';
import 'package:aking/logic/blocs/firestore/firestore_bloc.dart';
import 'package:aking/logic/models/project.dart';
import 'package:aking/logic/models/public_user_info.dart';
import 'package:aking/views/widgets/network_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:aking/logic/utils/extensions/logic_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ProjectRow extends StatelessWidget {
  const ProjectRow({
    Key? key,
    required this.project,
  }) : super(key: key);
  final String project;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final projectInfo =
        context.read<FirestoreBloc<Project>>().allDoc.findById(project);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 44.h,
          height: 44.h,
          child: Column(
            children: [
              SvgPicture.asset(
                AssetPathConstants.tagIcon,
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
              "Tag",
              overflow: TextOverflow.ellipsis,
              style: textTheme.button!.toBlurColor(),
            ),
            SizedBox(height: 8.h),
            () {
              return Container(
                height: 40.h,
                width: 90.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  border: Border.all(color: ExpandedColor.fromHex("#E8E8E8")),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      projectInfo != null ? projectInfo.title : "No project",
                      style: textTheme.subtitle1!.copyWith(
                        fontSize: 16.sp,
                        color: ExpandedColor.fromHex(projectInfo != null
                            ? projectInfo.hexColor
                            : "#000000"),
                      ),
                    ),
                  ],
                ),
              );
            }()
          ],
        ),
      ],
    );
  }
}
