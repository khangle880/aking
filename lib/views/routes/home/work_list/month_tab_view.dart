import 'package:aking/global/constants/assets_path.dart';
import 'package:aking/logic/blocs/task/tasks_group/tasks_group_bloc.dart';
import 'package:aking/logic/models/task.dart';
import 'package:aking/logic/provider/calendar.dart';
import 'package:aking/logic/utils/queries/filter.dart';
import 'package:aking/views/widgets/calendar.dart';
import 'package:aking/views/widgets/simple_rive_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:aking/logic/utils/extensions/logic_extensions.dart';

import 'day_tasks.dart';

class MonthTabView extends StatefulWidget {
  const MonthTabView({Key? key}) : super(key: key);

  @override
  _MonthTabViewState createState() => _MonthTabViewState();
}

class _MonthTabViewState extends State<MonthTabView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksGroupBloc, TasksGroupState>(
        builder: (context, state) {
      if (state is TasksGroupedByDate) {
        return ChangeNotifierProvider<CalendarProvider>(
          create: (_) => CalendarProvider(),
          child: Consumer<CalendarProvider>(builder: (_, value, __) {
            final List<Task> tasksInDay =
                getTasksInDay(state, value.selectedDay);

            return Column(
              children: [
                Calendar(eventLoader: (day) {
                  return getTasksInDay(state, day);
                }),
                // SizedBox(height: 20.w),
                if (tasksInDay.isNotEmpty)
                  DayTasks(date: value.selectedDay, tasksInDay: tasksInDay)
                else
                  Padding(
                    padding: EdgeInsets.only(top: 20.w),
                    child: Text(
                      "No tasks for this day",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  )
              ],
            );
          }),
        );
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
    });
  }

  List<Task> getTasksInDay(TasksGroupedByDate state, DateTime day) {
    final Map<DateTime, List<Task>> tasksFiltered = state.groupedTasks
        .filterByKey(pointSelected: day, option: OptionPointFilter.isEqualTo);
    final List<Task> events =
        tasksFiltered.isNotEmpty ? tasksFiltered.values.first : [];
    return events;
  }
}
