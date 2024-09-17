import 'package:choreapp_frontend/clients/chore_client.dart';
import 'package:choreapp_frontend/models/chore.dart';
import 'package:choreapp_frontend/widgets/chore_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

String formatTime(DateTime date) {
  String temp = '';
  int hour = date.hour;
  int minute = date.minute;
  if (hour < 10) {
    temp += "0";
  }
  temp += hour.toString();
  temp += ":";

  if (minute < 10) {
    temp += "0";
  }
  temp += minute.toString();
  return temp;
}

class ChoreDisplay extends StatefulWidget {
  final DateTime date;
  const ChoreDisplay(this.date, {super.key});

  @override
  State<ChoreDisplay> createState() => ChoreDisplayState();
}

class ChoreDisplayState extends State<ChoreDisplay> {
  static const Color white = Color(0xFFFFFFFF);
  static const Color pastelGreen = Color(0xFF77DD77);
  Future<List<Chore>>? choresList;
  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final choreClient = Provider.of<ChoreClient>(context);
    choresList = choreClient.getChoreByDateOnly(widget.date);
    return FractionallySizedBox(
      widthFactor: 0.88,
      heightFactor: 0.5,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 162, 199, 162),
          border: Border.all(),
          borderRadius: const BorderRadius.all(Radius.elliptical(4, 4)),
        ),
        child: FutureBuilder<List<Chore>>(
          future: choresList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading chores'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No chores found'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final chore = snapshot.data![index];
                  return ListTile(
                    title: Text(chore.name,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0))),
                    subtitle: Text('Due at: ${formatTime(chore.deadline)}'),
                    trailing: Icon(chore.done ? Icons.check : Icons.close,
                        color: chore.done ? Colors.green : Colors.red),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => ChoreFormPopup(
                          selectedDay: chore.deadline,
                          chore: chore,
                          onSave: _refresh,
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
