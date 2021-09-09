import 'package:aking/global/constants/app_constants.dart';
import 'package:aking/logic/models/task.dart';
import 'package:aking/views/utils/extensions/flush_bar.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:aking/views/widgets/empty_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:aking/logic/utils/extensions/logic_extensions.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'day_tasks.dart';

class TodayTabView extends StatefulWidget {
  const TodayTabView({Key? key, required this.tasksByDate}) : super(key: key);

  final Map<DateTime, List<Task>> tasksByDate;

  @override
  _TodayTabViewState createState() => _TodayTabViewState();
}

class _TodayTabViewState extends State<TodayTabView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  int? todayIndex;

  @override
  void initState() {
    super.initState();
    // scroll to today when open
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Future.delayed(
        Duration(milliseconds: 500),
        () => jumpToIndex(todayIndex),
      );
    });
  }

  void jumpToIndex(int? index) {
    if (index == null) return;
    itemScrollController.jumpTo(index: index);
  }

  void scrollToIndex(int? index) {
    if (index == null) return;

    itemScrollController.scrollTo(
        index: index,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOutCubic);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    for (var i = 0; i < widget.tasksByDate.length; i++) {
      if (widget.tasksByDate.keys.elementAt(i).isSameDate(DateTime.now())) {
        todayIndex = i;
      }
    }

    return widget.tasksByDate.isNotEmpty
        ? Stack(
            alignment: Alignment.bottomRight,
            children: [
              ScrollablePositionedList.builder(
                itemScrollController: itemScrollController,
                itemPositionsListener: itemPositionsListener,
                itemCount: widget.tasksByDate.entries.length,
                itemBuilder: (context, index) {
                  final item = widget.tasksByDate.entries.elementAt(index);
                  return DayTasks(
                    date: item.key,
                    tasksInDay: item.value,
                  );
                },
              ),
              Positioned(
                bottom: 12.h,
                right: 8.w,
                child: GestureDetector(
                  onTap: () {
                    if (todayIndex == null) {
                      ExpandedFlushbar.failureFlushbar(context,
                              message: "No Task Today")
                          .show(context);
                    } else {
                      scrollToIndex(todayIndex);
                    }
                  },
                  child: JumpTodayButton(
                    itemPositionsListener: itemPositionsListener,
                    todayIndex: todayIndex,
                  ),
                ),
              ),
            ],
          )
        : EmptyView();
  }
}

class JumpTodayButton extends StatefulWidget {
  const JumpTodayButton({
    Key? key,
    required this.itemPositionsListener,
    this.todayIndex,
  }) : super(key: key);

  final ItemPositionsListener itemPositionsListener;
  final int? todayIndex;

  @override
  _JumpTodayButtonState createState() => _JumpTodayButtonState();
}

class _JumpTodayButtonState extends State<JumpTodayButton> {
  bool isToday = false;

  @override
  void initState() {
    super.initState();
    widget.itemPositionsListener.itemPositions.addListener(() {
      final indices = widget.itemPositionsListener.itemPositions.value
          .where((e) =>
              (e.itemLeadingEdge <= 0.2 && e.itemLeadingEdge >= 0) ||
              (e.itemTrailingEdge <= 1))
          .map((e) => e.index)
          .toList();
      if (indices.isNotEmpty) {
        setState(() {
          isToday = indices.contains(widget.todayIndex);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      width: 45.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.r),
        gradient: ColorConstants.kPrimaryGradientColor,
      ),
      child: Icon(
        isToday ? Icons.my_location : Icons.location_searching,
        color: ExpandedColor.fromHex("#FFFFFF"),
      ),
    );
  }
}
