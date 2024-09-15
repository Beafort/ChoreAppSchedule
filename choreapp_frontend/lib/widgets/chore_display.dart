import 'package:choreapp_frontend/clients/chore_client.dart';
import 'package:choreapp_frontend/models/chore.dart';
import 'package:flutter/material.dart';

class ChoreDisplay extends StatefulWidget {
  final DateTime date;

  const ChoreDisplay(this.date, {super.key});

  @override
  State<ChoreDisplay> createState() => ChoreDisplayState();
}

class ChoreDisplayState extends State<ChoreDisplay> {
  static const Color white = Color(0xFFFFFFFF);
  static const Color pastelGreen = Color(0xFF77DD77);
  static const ChoreClient choreClient = ChoreClient();
  Future<List<Chore>>? choresList;

  @override
  Widget build(BuildContext context) {
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
                    subtitle: Text('Due on: ${chore.deadline}'),
                    trailing: Checkbox(
                      value: chore.done,
                      onChanged: null,
                    ),
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
