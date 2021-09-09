import 'package:aking/global/constants/assets_path.dart';
import 'package:aking/logic/blocs/firestore/firestore_bloc.dart';
import 'package:aking/logic/models/public_user_info.dart';
import 'package:aking/views/widgets/network_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:aking/logic/utils/extensions/logic_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class MembersRow extends StatelessWidget {
  const MembersRow({
    Key? key,
    required this.members,
  }) : super(key: key);
  final List<String>? members;

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
                AssetPathConstants.communityIcon,
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
              "Members",
              overflow: TextOverflow.ellipsis,
              style: textTheme.button!.toBlurColor(),
            ),
            SizedBox(height: 2.h),
            if (members == null || members!.isEmpty)
              Text(
                'No Members',
                style: textTheme.subtitle1!.copyWith(fontSize: 16.sp),
              )
            else
              SizedBox(
                height: 37.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: <Widget>[
                    ...members!.map(
                      (e) {
                        final memberInfo = context
                            .watch<FirestoreBloc<PublicUserInfo>>()
                            .allDoc
                            .findById(e);

                        return Padding(
                          padding: EdgeInsets.all(2.5.h),
                          child: memberInfo == null
                              ? NetworkAvatar(
                                  link: "",
                                  placehouderText: "",
                                  height: 32.h,
                                  width: 32.h,
                                )
                              : NetworkAvatar(
                                  link: memberInfo.avatarLink,
                                  placehouderText: memberInfo.name,
                                  height: 32.h,
                                  width: 32.h,
                                ),
                        );
                      },
                    ).toList(),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}
