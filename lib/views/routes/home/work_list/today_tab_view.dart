import 'dart:developer';

import 'package:aking/global/constants/assets_path.dart';
import 'package:aking/logic/blocs/task/tasks_group/tasks_group_bloc.dart';
import 'package:aking/logic/utils/modules/color_module.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aking/views/widgets/simple_rive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aking/logic/utils/extensions/logic_extensions.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'day_tasks.dart';

class TodayTabView extends StatefulWidget {
  const TodayTabView({Key? key}) : super(key: key);

  @override
  _TodayTabViewState createState() => _TodayTabViewState();
}

class _TodayTabViewState extends State<TodayTabView> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  late int todayIndex;

  @override
  void initState() {
    super.initState();
    // scroll to today when open
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Future.delayed(
        Duration(milliseconds: 500),
        () => itemScrollController.jumpTo(index: todayIndex),
      );
    });
  }

  void scrollToIndex(int index) => itemScrollController.scrollTo(
      index: index,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOutCubic);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksGroupBloc, TasksGroupState>(
      builder: (context, state) {
        if (state is TasksGroupedByDate) {
          final tasks = state.groupedTasks;
          for (var i = 0; i < tasks.length; i++) {
            if (tasks.keys.elementAt(i).isSameDate(DateTime.now())) {
              todayIndex = i;
            }
          }

          return tasks.isNotEmpty
              ? Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ScrollablePositionedList.builder(
                      itemScrollController: itemScrollController,
                      itemPositionsListener: itemPositionsListener,
                      itemCount: tasks.entries.length,
                      itemBuilder: (context, index) {
                        final item = tasks.entries.elementAt(index);
                        return DayTasks(date: item.key, tasksInDay: item.value);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: FloatingActionButton(
                        backgroundColor: hexToColor("#F96060"),
                        heroTag: "Scroll to today Button",
                        onPressed: () {
                          scrollToIndex(todayIndex);
                        },
                        child: Icon(Icons.pin_drop_outlined),
                      ),
                    ),
                  ],
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
