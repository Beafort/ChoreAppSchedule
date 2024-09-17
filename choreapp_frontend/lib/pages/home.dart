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
    if (selectedDay != null) {
      dayString = formatDate(selectedDay);
      day = selectedDay;
    } else {
      dayString = 'No day selected';
      day = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chore Distribution App (Very early development)',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        key: GlobalKey(),
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ChoreWeek(
                onDaySelected: _handleDaySelected,
                oldSelect: day, // Pass the callback
              ),
            ),

            if (dayString != null)
              Text("Chores for day of: ${dayString!}"), // Show the selected day
          ],
        ),
      ),
    );
  }
}
