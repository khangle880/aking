import 'package:aking/logic/models/task.dart';
import 'package:aking/logic/utils/modules/color_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ItemBody extends StatelessWidget {
  const ItemBody({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    final Color itemColorTheme =
        task.isDone ? hexToColor("#F96060") : hexToColor("#6074F9");
    final textTheme = Theme.of(context).textTheme;
    final textStyle = task.isDone
        ? textTheme.button!.copyWith(decoration: TextDecoration.lineThrough)
        : textTheme.button;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(5.w, 5.w),
            color: Color.fromRGBO(224, 224, 224, 0.5),
            blurRadius: 9.w,
          ),
        ],
      ),
      child: Card(
        shadowColor: Colors.transparent,
        child: ListTile(
          leading: LeadingButton(itemColorTheme: itemColorTheme, task: task),
          title: Text(task.title, style: textStyle),
          subtitle: Text(
            DateFormat('hh:mm a').format(task.dueDate ?? task.createdDate),
            style: textStyle!.copyWith(color: hexToColor("#9E9E9E")),
          ),
          contentPadding: EdgeInsets.only(left: 10.w),
          trailing: Container(
            color: itemColorTheme,
            width: 4.w,
            height: 21.h,
          ),
        ),
      ),
    );
  }
}

class LeadingButton extends StatelessWidget {
  const LeadingButton({
    Key? key,
    required this.itemColorTheme,
    required this.task,
  }) : super(key: key);

  final Color itemColorTheme;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {},
        icon: Container(
          width: 16.w,
          height: 16.w,
          decoration: BoxDecoration(
            border:
                Border.all(color: itemColorTheme, width: task.isDone ? 0 : 3.w),
            borderRadius: BorderRadius.circular(100.w),
            color: task.isDone ? itemColorTheme : null,
          ),
          child: Icon(
            task.isDone ? Icons.check : null,
            size: 14.w,
            color: Colors.white,
          ),
        ));
  }
}
