import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/chore.dart';

class ChoreClient {
  static const baseUrl = "http://10.0.2.2:5270/chores";
  //GET
  Future<Chore> getChoreById(int id) async {
    final response = await http.get(Uri.parse("$baseUrl/$id"));
    if (response.statusCode == 200) {
      return Chore.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('There are no chore with id of $id');
    }
  }

  //Get by datetime
  Future<List<Chore>> getChoreByDateOnly(DateTime date) async {
    int year = date.year;
    int month = date.month;
    int day = date.day;
    final response = await http.get(Uri.parse("$baseUrl/$year-$month-$day"));
    if (response.statusCode == 200) {
      // Decode the JSON and convert it into a list of Chore objects
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Chore.fromJson(json)).toList();
    } else if (response.statusCode == 404) {
      // If the server returns a 404, return an empty list.
      return [];
    } else {
      throw Exception('There are no chores for the date $year-$month-$day');
    }
  }

  //POST
  Future<http.Response> postChore(Chore chore) async {
    return http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'name': chore.name,
        'deadline': chore.deadline.toIso8601String()
      }),
    );
  }
}
