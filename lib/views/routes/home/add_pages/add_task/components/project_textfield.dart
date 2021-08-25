import 'package:aking/logic/blocs/firestore/firestore_bloc.dart';
import 'package:aking/logic/models/project.dart';
import 'package:aking/logic/models/public_user_info.dart';
import 'package:aking/logic/provider/add_task.dart';
import 'package:aking/logic/utils/modules/color_module.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectTextField extends StatelessWidget {
  const ProjectTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddTaskProvider>(
      builder: (context, value, child) {
        final projectInfo = getInfo(value.projectId, context);
        final inputStyle =
            Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14.sp);
        return Container(
          width: 90.w,
          height: 48.h,
          decoration: BoxDecoration(
            color: hexToColor("#F4F4F4"),
            borderRadius: BorderRadius.circular(50),
          ),
          child: value.forcusingStatus == FocusingStatus.project
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
                      .changeForcusingStatus(FocusingStatus.project),
                  child: Center(
                      child: Text(
                          projectInfo != null ? projectInfo.name : "Project",
                          style: inputStyle)),
                ),
        );
      },
    );
  }

  Project? getInfo(String uid, BuildContext context) {
    if (uid == "") return null;
    final filteredList = context
        .read<FirestoreBloc<Project>>()
        .allDoc
        .where((element) => element.id == uid);
    return filteredList.isEmpty ? null : filteredList.first;
  }
}
