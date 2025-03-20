import 'package:flutter/material.dart';
import 'package:lingocore/home_page.dart';
// UI elemanları birbirinden çok uzak
// Etraftaki paddingler çok az
// Google logosu eklenebilir X
// Kayıtlı kullanıcı değil misin? biraz daha yukarıda olabilir X
class LoginPage extends StatelessWidget{
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {

    //ekran yükekliğini al ve belli bi orana dönüştür
    double screenHeight = MediaQuery.of(context).size.height;
    double paddingLarge = screenHeight * 0.25;

    return Scaffold(
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_circle_outlined,
              size: 100,
            ),      
            Text(
              "Giriş Ekranı",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(paddingLarge),
              child: Material(
                color: Colors.grey[300],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: InkWell(
                  splashFactory: InkRipple.splashFactory,
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(
                      builder: (context) => HomePage()
                    )
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/google.png", height: 50,),
                      SizedBox(width: 15,),
                      Text(
                        "Google ile giriş yap",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                blackDivider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Kayıtlı kullanıcı değil misin?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                blackDivider(),
              ],
            ),
            Text(
              "Kayıt ol",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16
              ),
            ),
          ],
        ),
      ),
    );
  }

//siyah ayraç
Expanded blackDivider() {
    return Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: Colors.grey[600],
                    )
                );
  }
}