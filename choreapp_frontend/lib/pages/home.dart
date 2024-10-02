import 'package:choreapp_frontend/clients/user_client.dart';
import 'package:choreapp_frontend/models/user.dart';
import 'package:flutter/material.dart';
import 'package:choreapp_frontend/widgets/chore_week.dart';
import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}
UserClient userClient = UserClient();
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? dayString;
  DateTime? day;
  User? user;
  @override
  void initState() {
    super.initState();
    _loadUser(); 
  }
  Future<void> _loadUser() async {
   
    user = await userClient.getUser();
    if(user == null){
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/login');
    }
    setState(() {}); 
    
  }
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
          title: Text(user == null ? 'null' : user!.name),
          actions: [
            ElevatedButton(
              onPressed: () {
                userClient.logout();
                if (!mounted) return;
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: ButtonStyle(backgroundColor: WidgetStateProperty.all<Color>(Colors.red),),
              child: const Text("Log out"),
            ),
    // You can add more buttons or widgets here if needed
  ],
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


