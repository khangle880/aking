import 'package:aking/logic/models/task.dart';
import 'package:aking/logic/provider/calendar.dart';
import 'package:aking/logic/utils/queries/filter.dart';
import 'package:aking/views/widgets/calendar.dart';
import 'package:aking/views/widgets/empty_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aking/logic/utils/extensions/logic_extensions.dart';

import 'day_tasks.dart';

class MonthTabView extends StatefulWidget {
  const MonthTabView({Key? key, required this.tasksByDate}) : super(key: key);

  final Map<DateTime, List<Task>> tasksByDate;

  @override
  _MonthTabViewState createState() => _MonthTabViewState();
}

class _MonthTabViewState extends State<MonthTabView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final textTheme = Theme.of(context).textTheme;

    return ChangeNotifierProvider<CalendarProvider>(
      create: (_) => CalendarProvider(),
      child: Consumer<CalendarProvider>(builder: (_, value, __) {
        final List<Task> tasksInDay =
            getTasksInDay(widget.tasksByDate, value.selectedDay);

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Calendar(eventLoader: (day) {
              return getTasksInDay(widget.tasksByDate, day);
            }),
            // SizedBox(height: 20.w),
            if (tasksInDay.isNotEmpty)
              Expanded(
                child: SingleChildScrollView(
                  child:
                      DayTasks(date: value.selectedDay, tasksInDay: tasksInDay),
                ),
              )
            else
              Expanded(child: EmptyView())
          ],
        );
      }),
    );
  }

  List<Task> getTasksInDay(
      Map<DateTime, List<Task>> tasksByDate, DateTime day) {
    final Map<DateTime, List<Task>> tasksFiltered = tasksByDate.filterByKey(
        pointSelected: day, option: OptionPointFilter.isEqualTo);
    final List<Task> events =
        tasksFiltered.isNotEmpty ? tasksFiltered.values.first : [];
    return events;
  }
}
