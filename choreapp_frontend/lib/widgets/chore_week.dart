import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ChoreWeek extends StatefulWidget {
  final void Function(DateTime? selectedDay)? onDaySelected;

  const ChoreWeek({super.key, this.onDaySelected});

  @override
  State<ChoreWeek> createState() => _ChoreWeekState();
}

class _ChoreWeekState extends State<ChoreWeek> {
  DateTime date = DateUtils.dateOnly(DateTime.now());

  /// Get the Sunday of the current week
  DateTime getLastSunday() {
    int daysToSubtract = date.weekday % 7; // days since last Sunday
    return date.subtract(Duration(days: daysToSubtract));
  }

  /// Get the Saturday of the next week
  DateTime getNextSaturday() {
    int daysToNextSaturday =
        (6 - date.weekday + 7) % 7 + 7; // days to next Saturday
    return date.add(Duration(days: daysToNextSaturday));
  }

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarFormat: CalendarFormat.week, // Default to week view
      availableCalendarFormats: const {
        CalendarFormat.week: 'Week', // Only week view allowed
      },
      focusedDay: _focusedDay,
      firstDay: getLastSunday(), // Start from last Sunday
      lastDay: getNextSaturday(), // End at next Saturday
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        } else {
          setState(() {
            _selectedDay = null;
            _focusedDay = focusedDay;
          });
        }
        widget.onDaySelected?.call(_selectedDay); // Call the callback
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
    );
  }

  DateTime? getSelectedDay() {
    return _selectedDay;
  }
}
