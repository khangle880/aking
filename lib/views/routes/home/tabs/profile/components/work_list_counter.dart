import 'package:aking/logic/blocs/firestore/firestore_bloc.dart';
import 'package:aking/logic/blocs/task/get_task/task_bloc.dart';
import 'package:aking/logic/models/quick_note.dart';
import 'package:aking/logic/models/task.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class WorkListCounter extends StatelessWidget {
  const WorkListCounter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Task> allTasks = context.watch<TaskBloc>().allDoc;
    final List<QuickNote> allQuickNotes =
        context.watch<FirestoreBloc<QuickNote>>().allDoc;
    final events = allTasks.where((e) => e.dueDate != null);
    final todo = allTasks.where((e) => e.dueDate == null);

    return SizedBox(
      height: 100.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          WLCounterItem(
            title: "Events",
            numbers: events.length,
            color: ExpandedColor.fromHex("#F96060"),
          ),
          SizedBox(width: 10.w),
          WLCounterItem(
            title: "To do Tasks",
            numbers: todo.length,
            color: ExpandedColor.fromHex("#6074F9"),
          ),
          SizedBox(width: 10.w),
          WLCounterItem(
            title: "Quick Notes",
            numbers: allQuickNotes.length,
            color: ExpandedColor.fromHex("#8560F9"),
          ),
        ],
      ),
    );
  }
}

class WLCounterItem extends StatelessWidget {
  const WLCounterItem({
    Key? key,
    required this.title,
    required this.numbers,
    required this.color,
  }) : super(key: key);

  final String title;
  final int numbers;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
        width: 160.w,
        height: 100.h,
        padding: EdgeInsets.symmetric(
          vertical: 28.h,
          horizontal: 24.w,
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(224, 224, 224, 0.5),
              offset: Offset(0, 2.0),
              blurRadius: 10.r,
            )
          ],
          borderRadius: BorderRadius.circular(5.r),
          color: color,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: textTheme.subtitle1!
                    .copyWith(color: ExpandedColor.fromHex("#FFFFFF"))),
            Text("$numbers Tasks",
                style: textTheme.bodyText1!.copyWith(
                    fontSize: 14.sp, color: ExpandedColor.fromHex("#FFFFFF")))
          ],
        ));
  }
}
