import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lingocore/api/course.dart';
import 'api.dart';

class User {
  final String id;
  final String username;
  final String? email;
  final List<UserCourse> userCourses;

  User({
    required this.id,
    required this.username,
    this.email,
    required this.userCourses,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      userCourses:
          (json['userCourses'] as List<dynamic>)
              .map((item) => UserCourse.fromJson(item))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'userCourses': userCourses.map((course) => course.toJson()).toList(),
    };
  }
}

Future<User> userInfo(String username, String accessToken) async {
  final url = serverUrlBase.replace(path: '/api/user/$username');
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
