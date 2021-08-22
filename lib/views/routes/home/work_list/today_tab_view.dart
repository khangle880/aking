import 'package:aking/global/constants/assets_path.dart';
import 'package:aking/logic/blocs/tasks_group/tasks_group_bloc.dart';
import 'package:aking/logic/utils/queries/filter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aking/views/widgets/simple_rive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aking/logic/utils/extensions/extensions.dart';

import 'day_tasks.dart';

class TodayTabView extends StatelessWidget {
  const TodayTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksGroupBloc, TasksGroupState>(
      builder: (context, state) {
        if (state is TasksGroupedByDate) {
          final tasks = state.groupedTasks.filterByKey(
              pointSelected: DateTime.now(),
              option: OptionPointFilter.isGreaterThanOrEqualTo);

          return tasks.isNotEmpty
              ? ListView(
                  children: tasks.entries
                      .map((item) =>
                          DayTasks(date: item.key, tasksInDay: item.value))
                      .toList(),
                )
              : Center(
                  child: Text(
                  "No Task",
                  style: Theme.of(context).textTheme.headline4,
                ));
        } else {
          return Center(
            child: SimpleRiveWidget(
              rivePath: loader2Rive,
              simpleAnimation: loader2SimpleAnimation,
              width: 180.w,
              height: 180.h,
            ),
          );
        }
      },
    );
  }
}
