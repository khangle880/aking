import 'package:aking/logic/blocs/firestore/firestore_bloc.dart';
import 'package:aking/logic/blocs/task/get_task/task_bloc.dart';
import 'package:aking/logic/models/check_list.dart';
import 'package:aking/logic/models/note.dart';
import 'package:aking/logic/models/quick_note.dart';
import 'package:aking/logic/models/task.dart';
import 'package:aking/views/widgets/circular_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkListStatistic extends StatelessWidget {
  const WorkListStatistic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final List<Task> allTasks = context.watch<TaskBloc>().allDoc;
    final List<QuickNote> allQuickNotes =
        context.watch<FirestoreBloc<QuickNote>>().allDoc;

    final events = allTasks.where((e) => e.dueDate != null);
    final eventPercent =
        (events.where((e) => e.isDone).length / events.length * 100).round();

    final todo = allTasks.where((e) => e.dueDate == null);
    final todoPercent =
        (todo.where((e) => e.isDone).length / todo.length * 100).round();

    final quickNotePercent = (allQuickNotes.where((e) {
              if (e is Note) {
                return true;
              } else {
                return (e as CheckList)
                    .list
                    .where((element) => element.isDone)
                    .isNotEmpty;
              }
            }).length /
            allQuickNotes.length *
            100)
        .round();


    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Statistic", style: textTheme.subtitle1),
          SizedBox(height: 21.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatisticItem(
                percent: eventPercent,
                title: 'Events',
                color: ExpandedColor.fromHex("#F96969"),
              ),
              StatisticItem(
                percent: todoPercent,
                title: 'To do',
                color: ExpandedColor.fromHex("#6074F9"),
              ),
              StatisticItem(
                percent: quickNotePercent,
                title: 'Quick Notes',
                color: ExpandedColor.fromHex("#8560F9"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StatisticItem extends StatelessWidget {
  const StatisticItem({
    Key? key,
    required this.title,
    required this.percent,
    required this.color,
  }) : super(key: key);

  final String title;
  final int percent;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        CircularBorder(
          strokeWidth: 2,
          size: 80.h,
          color: color,
          backgroudColor: ExpandedColor.fromHex("#E8E8E8"),
          offsetDot: 6,
          ratioDot: 2,
          child: Text(
            "$percent%",
            style: textTheme.subtitle1,
          ),
        ),
        SizedBox(height: 14.h),
        Text(title, style: textTheme.button),
      ],
    );
  }
}
