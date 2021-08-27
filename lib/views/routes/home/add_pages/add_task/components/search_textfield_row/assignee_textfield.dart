import 'package:aking/logic/blocs/firestore/firestore_bloc.dart';
import 'package:aking/logic/models/public_user_info.dart';
import 'package:aking/logic/provider/add_task.dart';
import 'package:aking/logic/utils/extensions/list_extensions.dart';
import 'package:aking/logic/utils/modules/color_module.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:aking/views/widgets/network_avatar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssigneeTextField extends StatefulWidget {
  const AssigneeTextField({
    Key? key,
  }) : super(key: key);

  @override
  _AssigneeTextFieldState createState() => _AssigneeTextFieldState();
}

class _AssigneeTextFieldState extends State<AssigneeTextField> {
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Consumer<AddTaskProvider>(
      builder: (context, value, child) {
        final assigneeInfo = context
            .read<FirestoreBloc<PublicUserInfo>>()
            .allDoc
            .findById(value.assigneeId) as PublicUserInfo?;
        final inputStyle =
            Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14.sp);
        return Container(
          width: 90.w,
          height: 48.h,
          decoration: BoxDecoration(
            color: hexToColor("#F4F4F4"),
            borderRadius: BorderRadius.circular(50.r),
          ),
          child: value.forcusingStatus == FocusingStatus.assignee
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Center(
                    child: TextField(
                      style: inputStyle,
                      autofocus: true,
                      focusNode: focusNode,
                      decoration: InputDecoration().toNoneBorder(),
                      onChanged: (val) {
                        context
                            .read<AddTaskProvider>()
                            .changeAssigneeSearchText(val);
                      },
                    ),
                  ),
                )
              : InkWell(
                  onTap: () async {
                    context
                        .read<AddTaskProvider>()
                        .changeForcusingStatus(FocusingStatus.assignee);
                    Future.delayed(Duration(milliseconds: 100),
                        () => FocusScope.of(context).requestFocus(focusNode));
                  },
                  child: assigneeInfo != null
                      ? Row(
                          children: <Widget>[
                            // CircleAvatar(
                            //   backgroundImage: NetworkImage(assigneeInfo
                            //               .avatarLink !=
                            //           ""
                            //       ? assigneeInfo.avatarLink
                            //       : 'https://cdn.icon-icons.com/icons2/1674/PNG/512/person_110935.png'),
                            // )
                            //TODO: unlock networkAvatar
                            NetworkAvatar(link: assigneeInfo.avatarLink),
                            SizedBox(
                              width: 60.w,
                              child: Text(assigneeInfo.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: inputStyle),
                            ),
                          ],
                        )
                      : Center(
                          child: Text("Assignee", style: inputStyle),
                        ),
                ),
        );
      },
    );
  }
}
