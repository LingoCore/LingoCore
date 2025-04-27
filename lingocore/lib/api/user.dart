import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api.dart';

class User {
  final String id;
  final String username;
  final String? email;
  final List<String> courses;

  User({
    required this.id,
    required this.username,
    this.email,
    required this.courses,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      courses: List<String>.from(json['courses'] as List),
    );
  }
}

Future<User> getUser(String userId, String accessToken) async {
  final url = serverUrlBase.replace(path: '/api/user/$userId');
  final response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    },
  );
  final body = jsonDecode(response.body);
  if (response.statusCode == 200) {
    return User.fromJson(body['user']);
  } else {
    throw Exception('Failed to fetch user: ${body['message']}');
  }
}

Future<User> updateUser(
  String userId, {
  String? username,
  String? email,
  required String accessToken,
}) async {
  final url = serverUrlBase.replace(path: '/api/user/$userId');
  final payload = <String, dynamic>{};
  if (username != null) payload['username'] = username;
  if (email != null) payload['email'] = email;

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    },
    body: jsonEncode(payload),
  );
  final body = jsonDecode(response.body);
  if (response.statusCode == 200) {
    return User.fromJson(body['user']);
  } else {
    throw Exception('Failed to update user: ${body['message']}');
  }
}
