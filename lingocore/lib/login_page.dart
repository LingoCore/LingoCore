import 'package:flutter/material.dart';
import 'package:lingocore/dialogs/loginflow.dart';
import 'package:lingocore/theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ekran yükekliğini al ve belli bi orana dönüştür

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.35,
          bottom: 24,
          left: 16,
          right: 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Image.asset('assets/images/LingoCoreLogo.png', height: 100),
                Text(
                  "Giriş Ekranı",
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 20),
                ),
              ],
            ),
            Material(
              color: getFlavour(context).surface0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                splashFactory: InkRipple.splashFactory,
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return LoginFlow();
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 6,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/google.png", height: 50),
                      SizedBox(width: 10),
                      Text(
                        "Google ile giriş yap",
                        style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              // bottom section locked at bottom by spaceBetween
              children: [
                Row(
                  children: [
                    blackDivider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "© LingoCore - 2025",
                        style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 16),
                      ),
                    ),
                    blackDivider(),
                  ],
                ),
                Text(
                  "Tüm Hakları Saklıdır.",
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //siyah ayraç
  Expanded blackDivider() {
    return Expanded(child: Divider(thickness: 0.5, color: Colors.grey[600]));
  }
}
