import 'package:aking/logic/provider/calendar.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key, required this.eventLoader}) : super(key: key);
  final List<dynamic> Function(DateTime day) eventLoader;

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Consumer<CalendarProvider>(
      builder: (_, value, __) => TableCalendar(
        firstDay: value.firstDay,
        lastDay: value.lastDay,
        focusedDay: value.focusedDay,
        startingDayOfWeek: value.startingDayOfWeek,
        selectedDayPredicate: (day) {
          return isSameDay(value.selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          value.selectedDay = selectedDay;
          value.focusedDay = focusedDay;
        },
        calendarFormat: value.calendarFormat,
        onFormatChanged: (format) {
          value.calendarFormat = format;
        },
        onPageChanged: (focusedDay) {
          value.focusedDay = focusedDay;
        },
        eventLoader: (day) => widget.eventLoader(day),
        calendarStyle: CalendarStyle(
          markersMaxCount: 1,
          markerDecoration: BoxDecoration(
            color: ExpandedColor.fromHex("#F96060"),
            shape: BoxShape.circle,
          ),
          markerSizeScale: 0.15,
          selectedDecoration: BoxDecoration(
            color: ExpandedColor.fromHex("#0281F9"),
            shape: BoxShape.circle,
          ),
          selectedTextStyle: textTheme.subtitle2!
              .copyWith(color: Colors.white, fontWeight: FontWeight.w900),
          todayDecoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border:
                Border.all(color: ExpandedColor.fromHex("#9A9CFF"), width: 2.w),
          ),
          todayTextStyle: textTheme.bodyText1!.copyWith(fontSize: 14.sp),
          defaultTextStyle: textTheme.bodyText1!.copyWith(fontSize: 14.sp),
          outsideTextStyle: textTheme.bodyText1!.copyWith(
              fontSize: 14.sp, color: ExpandedColor.fromHex("#9E9E9E")),
        ),
        headerStyle: HeaderStyle(
          leftChevronVisible: false,
          rightChevronVisible: false,
          headerMargin: EdgeInsets.only(left: 145.w, right: 115.w),
          titleTextStyle: textTheme.subtitle2!,
          titleCentered: true,
          titleTextFormatter: (date, locale) =>
              DateFormat.yMMMM(locale).format(date).toUpperCase(),
          formatButtonDecoration: BoxDecoration(),
          formatButtonTextStyle: textTheme.subtitle1!,
          formatButtonPadding: EdgeInsets.only(bottom: 3.w),
          formatButtonShowsNext: false,
        ),
        availableCalendarFormats: const {
          CalendarFormat.month: "△",
          CalendarFormat.week: "▽",
          CalendarFormat.twoWeeks: "▽"
        },
        daysOfWeekStyle: DaysOfWeekStyle(
          dowTextFormatter: (date, locale) =>
              DateFormat.E(locale).format(date)[0],
          weekdayStyle: textTheme.bodyText1!.copyWith(
              fontSize: 14.sp, color: ExpandedColor.fromHex("#9A9A9A")),
          weekendStyle: textTheme.bodyText1!.copyWith(
              fontSize: 14.sp, color: ExpandedColor.fromHex("#9A9A9A")),
        ),
      ),
    );
  }
}
