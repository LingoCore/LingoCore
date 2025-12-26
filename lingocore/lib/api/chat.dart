import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api.dart';

Future<String> sendChatMessage(String message, String accessToken) async {
  final url = serverUrlBase.replace(path: '/api/chat');

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({'message': message}),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body['response'];
    } else {
      throw Exception('Failed to send message: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error sending message: $e');
  }
}
