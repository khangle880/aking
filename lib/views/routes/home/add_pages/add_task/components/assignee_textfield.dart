import 'package:aking/logic/blocs/firestore/firestore_bloc.dart';
import 'package:aking/logic/models/public_user_info.dart';
import 'package:aking/logic/provider/add_task.dart';
import 'package:aking/logic/utils/modules/color_module.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssigneeTextField extends StatelessWidget {
  const AssigneeTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddTaskProvider>(
      builder: (context, value, child) {
        final assigneeInfo = getInfo(value.assigneeId, context);
        print(assigneeInfo);
        final inputStyle =
            Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14.sp);
        return Container(
          width: 90.w,
          height: 48.h,
          decoration: BoxDecoration(
            color: hexToColor("#F4F4F4"),
            borderRadius: BorderRadius.circular(50),
          ),
          child: value.forcusingStatus == FocusingStatus.assignee
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Center(
                    child: TextField(
                      style: inputStyle,
                      autofocus: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                )
              : InkWell(
                  onTap: () => context
                      .read<AddTaskProvider>()
                      .changeForcusingStatus(FocusingStatus.assignee),
                  child: assigneeInfo != null
                      ? Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: NetworkImage(assigneeInfo
                                          .avatarLink !=
                                      ""
                                  ? assigneeInfo.avatarLink
                                  : 'https://cdn.icon-icons.com/icons2/1674/PNG/512/person_110935.png'),
                            )
                          ],
                        )
                      : Center(child: Text("Assignee", style: inputStyle)),
                ),
        );
      },
    );
  }

  PublicUserInfo? getInfo(String uid, BuildContext context) {
    if (uid == "") return null;
    final filteredList = context
        .read<FirestoreBloc<PublicUserInfo>>()
        .allDoc
        .where((element) => element.id == uid);
    print(uid);
    print(filteredList);
    return filteredList.isEmpty ? null : filteredList.first;
  }
}
