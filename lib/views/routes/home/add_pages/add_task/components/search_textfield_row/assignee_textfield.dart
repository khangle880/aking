import 'package:aking/logic/blocs/task/add_task/add_task_bloc.dart';
import 'package:aking/logic/blocs/firestore/firestore_bloc.dart';
import 'package:aking/logic/models/public_user_info.dart';
import 'package:aking/logic/utils/extensions/list_extensions.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:aking/views/widgets/network_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTaskBloc, AddTaskState>(
      builder: (context, state) {
        final assigneeInfo = context
            .watch<FirestoreBloc<PublicUserInfo>>()
            .allDoc
            .findById(state.assigneeId) as PublicUserInfo?;
        final inputStyle =
            Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14.sp);

        return SizedBox(
          width: 130.w,
          child: Row(
            children: [
              Container(
                constraints: BoxConstraints(minWidth: 90.w, maxWidth: 130.w),
                width: (state.focusingStatus == FocusingStatus.assignee ||
                        assigneeInfo == null ||
                        (inputStyle.textSize(assigneeInfo.name).width < 32.w))
                    ? 90.w
                    : 130.w,
                height: 48.h,
                decoration: BoxDecoration(
                  color: ExpandedColor.fromHex("#F4F4F4"),
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: state.focusingStatus == FocusingStatus.assignee
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Center(
                          child: TextField(
                            textCapitalization: TextCapitalization.sentences,
                            style: inputStyle,
                            autofocus: true,
                            decoration: InputDecoration().toNoneBorder(),
                            onChanged: (val) {
                              context.read<AddTaskBloc>().add(
                                  AssigneeSearchStringOnChange(
                                      assigneeSearchString: val));
                            },
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () async {
                          context.read<AddTaskBloc>().add(
                              FocusingStatusOnChange(
                                  focusingStatus: FocusingStatus.assignee));
                        },
                        child: assigneeInfo != null
                            ? Row(
                                children: <Widget>[
                                  NetworkAvatar(
                                    link: assigneeInfo.avatarLink,
                                    width: 48.h,
                                    height: 48.h,
                                  ),
                                  SizedBox(width: 8.w),
                                  SizedBox(
                                    width: inputStyle
                                                .textSize(assigneeInfo.name)
                                                .width <
                                            32.w
                                        ? 32.w
                                        : 72.w,
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
              ),
              Spacer(),
            ],
          ),
        );
      },
    );
  }
}
