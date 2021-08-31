import 'package:aking/logic/blocs/firestore/firestore_bloc.dart';
import 'package:aking/logic/blocs/process_state.dart';
import 'package:aking/logic/blocs/process_task/process_task_bloc.dart';
import 'package:aking/logic/models/task.dart';
import 'package:aking/logic/repositories/firestore/task_repository.dart';
import 'package:aking/logic/utils/extensions/logic_extensions.dart';
import 'package:aking/logic/utils/modules/color_module.dart';
import 'package:aking/views/utils/extensions/flush_bar.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:another_flushbar/flushbar.dart';
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
          //TODO: update isDone
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
    return BlocProvider<ProcessTaskBloc>(
      create: (context) => ProcessTaskBloc(TaskRepository()),
      child: BlocConsumer<ProcessTaskBloc, ProcessState>(
        listener: (context, state) {
          if (state is Processing) {
            ExpandedFlushbar.loadingFlushbar(context, "Updating").show(context);
          }
          if (state is ProcessFailure) {
            ExpandedFlushbar.failureFlushbar(context, state.errorMessage)
                .show(context);
          }
          if (state is Processing) {
            ExpandedFlushbar.successFlushbar(context, 'Update Successfully!')
                .show(context);
          }
        },
        builder: (context, state) {
          return IconButton(
              onPressed: () {
                print(task.isDone);
                context.read<ProcessTaskBloc>().add(UpdateCompleteStatus(
                    completeStatus: !task.isDone, id: task.id));
              },
              icon: Container(
                width: 16.w,
                height: 16.w,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: itemColorTheme, width: task.isDone ? 0 : 3.w),
                  borderRadius: BorderRadius.circular(100.r),
                  color: task.isDone ? itemColorTheme : null,
                ),
                child: Icon(
                  task.isDone ? Icons.check : null,
                  size: 14.w,
                  color: Colors.white,
                ),
              ));
        },
      ),
    );
  }
}
