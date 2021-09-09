import 'package:aking/global/constants/assets_path.dart';
import 'package:aking/logic/blocs/task/get_task/task_bloc.dart';
import 'package:aking/logic/blocs/task/process_task/process_task_bloc.dart';
import 'package:aking/views/routes/home/tabs/work_list/view_task_details/components/more_detail_body.dart';
import 'package:aking/views/routes/home/tabs/work_list/view_task_details/components/project_row.dart';
import 'package:aking/views/utils/extensions/flush_bar.dart';
import 'package:aking/views/widgets/empty_view.dart';
import 'package:aking/views/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:aking/logic/utils/extensions/logic_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'assigned_to_row.dart';
import 'description_row.dart';
import 'due_date_row.dart';
import 'members_row.dart';

class TaskDetailsBody extends StatelessWidget {
  const TaskDetailsBody({
    Key? key,
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    final taskBloc = context.watch<TaskBloc>();
    final idTask = taskBloc.currentTask;

    if (idTask == null) return EmptyView();
    final task = taskBloc.allDoc.findById(idTask);
    if (task == null) return EmptyView();
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      height: 660.h,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        children: [
          Text(task.title, style: textTheme.subtitle1),
          SizedBox(height: 25.h),
          AssignedToRow(assignedToId: task.assignedToId),
          Divider(
            color: ExpandedColor.fromHex("#E4E4E4"),
            height: 40.h,
            thickness: 1.h,
          ),
          DueDateRow(dueDate: task.dueDate),
          Divider(
            color: ExpandedColor.fromHex("#E4E4E4"),
            height: 40.h,
            thickness: 1.h,
          ),
          DescriptionRow(description: task.description),
          Divider(
            color: ExpandedColor.fromHex("#E4E4E4"),
            height: 40.h,
            thickness: 1.h,
          ),
          MembersRow(members: task.members),
          Divider(
            color: ExpandedColor.fromHex("#E4E4E4"),
            height: 40.h,
            thickness: 1.h,
          ),
          ProjectRow(project: task.projectId),
          SizedBox(height: 32.h),
         MoreDetailBody(task: task),
        ],
      ),
    );
  }
}
