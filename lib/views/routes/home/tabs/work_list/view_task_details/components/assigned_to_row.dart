import 'package:aking/logic/blocs/firestore/firestore_bloc.dart';
import 'package:aking/logic/models/public_user_info.dart';
import 'package:aking/views/widgets/network_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:aking/logic/utils/extensions/logic_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssignedToRow extends StatelessWidget {
  const AssignedToRow({
    Key? key,
    required this.assignedToId,
  }) : super(key: key);
  final String assignedToId;

  @override
  Widget build(BuildContext context) {
    final assignedInfo = context
            .read<FirestoreBloc<PublicUserInfo>>()
            .allDoc
            .findById(assignedToId) ??
        PublicUserInfo(
          id: "",
          email: "Not Found",
          name: "Not Found",
          avatarLink: "",
          status: false,
          description: "Not Found",
        );
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: <Widget>[
        NetworkAvatar(
          link: assignedInfo.avatarLink,
          width: 44.h,
          height: 44.h,
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Assigned to",
              overflow: TextOverflow.ellipsis,
              style: textTheme.button!.toBlurColor(),
            ),
            SizedBox(height: 2.h),
            Text(
              assignedInfo.name,
              overflow: TextOverflow.ellipsis,
              style: textTheme.subtitle1!.copyWith(fontSize: 16.sp),
            ),
          ],
        ),
      ],
    );
  }
}
