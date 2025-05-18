import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lingocore/api/api.dart';

enum TokenType { access, refresh }
String tokenTypeToString(TokenType type) {
  switch (type) {
    case TokenType.access:
      return "access";
    case TokenType.refresh:
      return "refresh";
  }
}

class Tokens {
  String accessToken;
  String refreshToken;

  Tokens({required this.accessToken, required this.refreshToken});
}

Future<Tokens> testlogin(String username) async {
  final url = serverUrlBase.replace(path: "/api/auth/testlogin");
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'username': username}),
  );
  final responseBody = jsonDecode(response.body);
  if (response.statusCode == 200) {
    return Tokens(
      accessToken: responseBody['accessToken'],
      refreshToken: responseBody['refreshToken'],
    );
  } else {
    throw Exception('Failed to login: ${responseBody['message']}');
  }
}

class TokenInfo {
  final String id;
  final TokenType type;
  final int version;
  final int iat;
  final int exp;

  TokenInfo({
    required this.id,
    required this.type,
    required this.version,
    required this.iat,
    required this.exp,
  });

  factory TokenInfo.fromJson(Map<String, dynamic> json) {
    return TokenInfo(
      id: json['id'],
      type: TokenType.values.firstWhere(
        (e) => e.toString() == 'TokenType.${json['type']}',
      ),
      version: json['version'],
      iat: json['iat'],
      exp: json['exp'],
    );
  }

  Map<String, dynamic>? toJson() {
    return {
      'id': id,
      'type': type.toString().split('.').last,
      'version': version,
      'iat': iat,
      'exp': exp,
    };
  }
}

Future<TokenInfo> tokenInfo(String token, TokenType type) async {
  final url = serverUrlBase.replace(path: "api/auth/tokeninfo");
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({"token": token, "type": tokenTypeToString(type)}),
  );
  final responseBody = jsonDecode(response.body);
  if (responseBody["error"] != null) {
    throw Exception('Failed to get token info: ${responseBody["error"]}');
  }
  return TokenInfo.fromJson(responseBody);
}
