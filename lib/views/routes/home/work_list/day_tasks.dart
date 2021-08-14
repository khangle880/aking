import 'package:aking/logic/models/task.dart';
import 'package:aking/logic/utils/modules/color_module.dart';
import 'package:aking/logic/utils/modules/datetime_module.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import 'task_item/task_item.dart';

class DayTasks extends StatefulWidget {
  const DayTasks({Key? key, required this.date, required this.tasksInDay})
      : super(key: key);

  final DateTime date;
  final List<Task> tasksInDay;

  @override
  _DayTasksState createState() => _DayTasksState();
}

class _DayTasksState extends State<DayTasks> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        SizedBox(
          height: 24.h,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 20.w),
          child: Text(
            toRelativeFormat(widget.date).toUpperCase(),
            style: textTheme.subtitle2!.copyWith(color: hexToColor("#9A9A9A")),
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(
          height: 18.h,
        ),
        ListView.builder(
          itemCount: widget.tasksInDay.length,
          itemBuilder: (context, index) {
            return TaskItem(
              task: widget.tasksInDay[index],
            );
          },
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
        ),
      ],
    );
  }
}
