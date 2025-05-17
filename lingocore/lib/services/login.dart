import 'package:lingocore/api/auth.dart';
import 'package:lingocore/api/user.dart';
import 'package:lingocore/globals.dart';

Future<void> handleLogin(String username) async {
  try {
    tokens = await testlogin(username);
    loggedInUser = await userInfo(username, tokens!.accessToken);
    saveGlobals();
  } catch (e) {
    throw Exception('Giriş işlemi başarısız: $e');
  }
}
