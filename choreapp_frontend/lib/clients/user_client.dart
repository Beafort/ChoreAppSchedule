import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/chore.dart';

class UserClient {
  static const baseUrl = "https://api.beafort.com/user";

  Future<http.Response> login(String email, String password) async {
    var response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'name': email,
        'password': password,
      }),
    );
  }
}
