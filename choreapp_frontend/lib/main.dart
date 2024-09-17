import 'package:choreapp_frontend/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'clients/chore_client.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<ChoreClient>(create: (_) => ChoreClient()),
      ],
      child: const MainApp(),
    ),
  );
}

class SnackbarGlobal {
  static GlobalKey<ScaffoldMessengerState> key =
      GlobalKey<ScaffoldMessengerState>();

  static void show(String message) {
    key.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chore App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
      scaffoldMessengerKey: SnackbarGlobal.key, // Your main home widget
    );
  }
}
