import 'package:aking/logic/blocs/task/process_task/process_task_bloc.dart';
import 'package:aking/logic/models/task.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final Color itemColorTheme = task.isDone
        ? ExpandedColor.fromHex("#F96060")
        : ExpandedColor.fromHex("#6074F9");
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
            style: textStyle!.copyWith(color: ExpandedColor.fromHex("#9E9E9E")),
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

class LeadingButton extends StatefulWidget {
  const LeadingButton({
    Key? key,
    required this.itemColorTheme,
    required this.task,
  }) : super(key: key);

  final Color itemColorTheme;
  final Task task;

  @override
  _LeadingButtonState createState() => _LeadingButtonState();
}

class _LeadingButtonState extends State<LeadingButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<ProcessTaskBloc>().add(UpdateCompleteStatus(
            completeStatus: !widget.task.isDone, id: widget.task.id));
      },
      icon: Container(
        width: 16.w,
        height: 16.w,
        decoration: BoxDecoration(
          border: Border.all(
              color: widget.itemColorTheme,
              width: widget.task.isDone ? 0 : 3.w),
          borderRadius: BorderRadius.circular(100.r),
          color: widget.task.isDone ? widget.itemColorTheme : null,
        ),
        child: Icon(
          widget.task.isDone ? Icons.check : null,
          size: 14.w,
          color: Colors.white,
        ),
      ),
    );
  }
}
