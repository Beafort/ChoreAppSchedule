import 'package:choreapp_frontend/clients/chore_client.dart';

import 'chore.dart';
import 'package:provider/provider.dart';

class User {
  final String? id;
  final String name;
  final String password;
  final List<Chore>? chores;
  const User(
      {this.id, required this.name, required this.password, this.chores});
  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'name': String name,
        'password': String password,
        'chores': List<Chore> chores,
      } =>
        User(id: id, name: name, password: password, chores: chores),
      _ => throw const FormatException('Failed to load json')
    };
  }
  Future<List<Chore>> getChores(List<int> choreIds) async {
    List<Chore> returnList = [];
    ChoreClient choreClient = ChoreClient();
    for (var choreId in choreIds) {
      Chore chore = await choreClient.getChoreById(choreId);
      returnList.add(chore);
    }
    return returnList;
  }
}
