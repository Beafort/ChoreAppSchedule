import 'dart:convert';
import 'package:choreapp_frontend/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

AndroidOptions _getAndroidOptions() => const AndroidOptions(
          encryptedSharedPreferences: true,
        );
final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
class UserClient {
  static const baseUrl = "https://api.beafort.com/user";
  
  Future<Map<String, String>> register(String email, String password, String name) async {
  var response = await http.post(
    Uri.parse('$baseUrl/register'),
    headers: <String, String>{
      'Content-Type': 'application/json'
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
      'name': name,
    }
    ),
  );
  
  
  if (response.statusCode == 200) {
    return {'status': 'success', 'message': 'User registered successfully.'};
  } else {
    List<dynamic> errorResponse = jsonDecode(response.body);

    // Create a map to hold the errors
    Map<String, String> errors = {};

    // Iterate through each error in the response
    for (var error in errorResponse) {
      if (error['code'] == 'DuplicateUserName' || error['code'] == 'DuplicateEmail') {
        errors[error['code']] = error['description'];
      }
    }

    // If no specific errors were added, provide a generic error message
    if (errors.isEmpty) {
      errors['error'] = 'An unknown error occurred.';
    }

    return errors;
  }
}
  //login
  Future<Map<String, String>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('https://api.beafort.com/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Parse the JSON response
      final data = jsonDecode(response.body);
      String accessToken = data['accessToken'];
      String refreshToken = data['refreshToken'];
      // Return the tokens as a map
      return {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      };
    } 
    else if(response.statusCode == 401) {
      final data = jsonDecode(response.body);
      String detail = data['detail'];
      switch (detail) {
        case "LockedOut":
          throw Exception('Too many attempts!');
      }
      throw Exception('Wrong email or password!');
    }
    else {
      throw Exception('Failed to login: ${response.body}');
    }
  }
  
  Future<bool> refreshToken() async{
    var key = await storage.read(key: "refreshToken");
    var response = await http.post(Uri.parse('https://222.255.119.23/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'refreshToken' : key!
          }
        )
      );
      if (response.statusCode == 200) {
      // Parse the JSON response
      final data = jsonDecode(response.body);
      String accessToken = data['accessToken'];
      String refreshToken = data['refreshToken'];
      // Return the tokens as a map
      storage.write(key: "accessToken", value: accessToken);
      storage.write(key: "refreshToken", value: refreshToken);
      return true;
    } else if(response.statusCode == 401) {
      storage.deleteAll();
      return false;
    }
    return false;
  }
  Future<User?> getUser() async {
    String? key = await storage.read(key: "accessToken");
    var response = await http.get(Uri.parse("$baseUrl/info"),
    headers: <String, String>{
        'Authorization': 'Bearer $key',
      },);
    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      return User.fromJson(data);
    }else if(response.statusCode == 401){
      if(await refreshToken() == true){
        String? key = await storage.read(key: "accessToken");
        response = await http.get(Uri.parse("$baseUrl/info"),
        headers: <String, String>{
            'Authorization': 'Bearer $key',
          }
        );
        final data = jsonDecode(response.body);
        return User.fromJson(data);
      }
    }
    return null;
  }
  Future<void> logout() async {
    String? key = await storage.read(key: "accessToken");
    http.post(Uri.parse("$baseUrl/logout"),
    headers: <String, String>{
            'Authorization': 'Bearer $key',
          }
        );
    storage.deleteAll();
  }
}
