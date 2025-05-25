import 'dart:convert';

import 'package:lingocore/api/auth.dart';
import 'package:lingocore/api/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

User? loggedInUser;
Tokens? tokens;

Future checkSavedGlobals() async {
  final prefs = await SharedPreferences.getInstance();

  final accessToken = prefs.getString("accesstoken");
  final refreshToken = prefs.getString("refreshtoken");
  if (accessToken != null && refreshToken != null) {
    tokens = Tokens(accessToken: accessToken, refreshToken: refreshToken);
  }

  final userJson = prefs.getString("userjson");
  if (userJson != null) {
    loggedInUser = User.fromJson(jsonDecode(userJson));
  }
}

saveGlobals() async {
  final prefs = await SharedPreferences.getInstance();
  if (tokens != null) {
    await prefs.setString("accesstoken", tokens!.accessToken);
    await prefs.setString("refreshtoken", tokens!.refreshToken);
  }
  if (loggedInUser != null) {
    await prefs.setString("userjson", jsonEncode(loggedInUser!.toJson()));
  }
}

clearGlobals() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove("userjson");
  await prefs.remove("accesstoken");
  await prefs.remove("refreshtoken");
  loggedInUser = null;
  tokens = null;
}
