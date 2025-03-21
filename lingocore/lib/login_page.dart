import 'package:flutter/material.dart';
import 'package:lingocore/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ekran yükekliğini al ve belli bi orana dönüştür

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Icon(Icons.account_circle_outlined, size: 100),
              Text(
                "Giriş Ekranı",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ],
          ),

          Material(
            color: Colors.grey[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              splashFactory: InkRipple.splashFactory,
              borderRadius: BorderRadius.circular(10),
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),),
                  ),
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
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  blackDivider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "© LingoCore - 2025",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                  blackDivider(),
                ],
              ),
              Text(
                "Tüm Hakları Saklıdır.",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //siyah ayraç
  Expanded blackDivider() {
    return Expanded(child: Divider(thickness: 0.5, color: Colors.grey[600]));
  }
}
