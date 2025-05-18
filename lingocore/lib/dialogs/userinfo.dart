import 'package:flutter/material.dart';
import 'package:lingocore/globals.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';


class UserInfoDialog extends StatelessWidget {
  const UserInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    if (loggedInUser == null) {
      return Dialog(
        child: ErrorWidget("Kullanıcı bilgileri yüklenemedi."),
      );
    }
    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.6,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Kullanıcı Bilgileri",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Divider(thickness: 1),
                // const SizedBox(height: 10),
                Text("Kullanıcı adı: ${loggedInUser?.username}"),
                Text("E-posta: ${loggedInUser?.email}"),
                Text("ID: ${loggedInUser?.id}"),
                const Divider(thickness: 1),
                Text("Kurs Sayısı: ${loggedInUser?.userCourses.length}"),
                loggedInUser!.userCourses.isNotEmpty
                    ? Column(
                      children:
                          loggedInUser!.userCourses
                              .map(
                                (usercourse) => Text(
                                  textAlign: TextAlign.center,
                                  "-> ${usercourse.course?.displayName} (ID: ${usercourse.course?.id})",
                                ),
                              )
                              .toList(),
                    )
                    : const Text("Kurs yok"),
                const Divider(thickness: 1),
                Text("Access Token:"),
                Text(
                  "Expires at: ${DateTime.fromMillisecondsSinceEpoch(JWT.decode(tokens!.accessToken).payload['exp'] * 1000)}",
                ),
                Text("Refresh Token:"),
                Text(
                  "Expires at: ${DateTime.fromMillisecondsSinceEpoch(JWT.decode(tokens!.refreshToken).payload['exp'] * 1000)}",
                ),
                const Divider(thickness: 1),
                TextButton(
                  onPressed: () async {
                    clearGlobals();
                    Navigator.pushReplacementNamed(context, "login");
                  },
                  child: const Text(
                    "Çıkış Yap",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
