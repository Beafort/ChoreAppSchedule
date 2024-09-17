import 'package:choreapp_frontend/widgets/chore_display.dart';
import 'package:choreapp_frontend/widgets/chore_form.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ChoreWeek extends StatefulWidget {
  final void Function(DateTime? selectedDay)? onDaySelected;
  final DateTime? oldSelect;

  const ChoreWeek({super.key, this.onDaySelected, this.oldSelect});

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
    return Column(
      children: [
        TableCalendar(
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
            widget.onDaySelected?.call(selectedDay); // Call the callback
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
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
        ),
        if (_selectedDay != null) Flexible(child: ChoreDisplay(_selectedDay!)),
        if (_selectedDay != null)
          Row(
            children: [
              Flexible(
                  child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => ChoreFormPopup(
                            selectedDay: _selectedDay,
                            onSave: () => _refreshChoreDisplay(),
                          ),
                        );
                      },
                      child: const Text('New Chore')))
            ],
          ),
      ],
    );
  }

  void _refreshChoreDisplay() {
    setState(() {});
  }

  DateTime? getSelectedDay() {
    return _selectedDay;
  }
}
