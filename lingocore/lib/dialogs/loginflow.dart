import 'package:flutter/material.dart';
import 'package:lingocore/services/login.dart';

class LoginFlow extends StatelessWidget {
  const LoginFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: handleLogin("deniztunc"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Dialog(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Giriş yapılıyor...'),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return AlertDialog(
            title: const Text('Hata'),
            content: Text('Giriş başarısız: ${snapshot.error}'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Tamam'),
              ),
            ],
          );
        } else {
          // Close all the pages and navigate to the home page
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil("home", (route) => false);
          });
          return const SizedBox.shrink();
        }
      },
    );
  }
}
