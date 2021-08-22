import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarProvider with ChangeNotifier {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;
  StartingDayOfWeek _startingDayOfWeek = StartingDayOfWeek.monday;
  DateTime _firstDay = DateTime.utc(2010, 10, 16);
  DateTime _lastDay = DateTime.utc(2030, 3, 14);

  DateTime get selectedDay => _selectedDay;
  set selectedDay(DateTime value) {
    _selectedDay = value;
    notifyListeners();
  }

  DateTime get focusedDay => _focusedDay;
  set focusedDay(DateTime value) {
    _focusedDay = value;
    notifyListeners();
  }

  CalendarFormat get calendarFormat => _calendarFormat;
  set calendarFormat(CalendarFormat value) {
    _calendarFormat = value;
    notifyListeners();
  }

  StartingDayOfWeek get startingDayOfWeek => _startingDayOfWeek;
  set startingDayOfWeek(StartingDayOfWeek value) {
    _startingDayOfWeek = value;
    notifyListeners();
  }

  DateTime get firstDay => _firstDay;
  set firstDay(DateTime value) {
    _firstDay = value;
    notifyListeners();
  }

  DateTime get lastDay => _lastDay;
  set lastDay(DateTime value) {
    _lastDay = value;
    notifyListeners();
  }
}
