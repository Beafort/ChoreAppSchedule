import 'package:choreapp_frontend/widgets/chore_display.dart';
import 'package:flutter/material.dart';
import 'package:choreapp_frontend/widgets/chore_week.dart';
import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? dayString;
  DateTime? day;

  void _handleDaySelected(DateTime? selectedDay) {
    // Only update if the selected day is different from the current one
    if (selectedDay != day) {
      setState(() {
        if (selectedDay != null) {
          dayString = formatDate(selectedDay);
          day = selectedDay;
        } else {
          dayString = 'No day selected';
          day = null;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ChoreWeek(
                onDaySelected: _handleDaySelected, // Pass the callback
              ),
            ),
            if (dayString != null)
              Text("Chores for day of: ${dayString!}"), // Show the selected day
            if (day != null)
              Flexible(child: ChoreDisplay(day!)), // Update display
          ],
        ),
      ),
    );
  }
}
