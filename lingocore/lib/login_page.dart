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
    return Scaffold(
      
      body: Center(
        child: Column(
          children: [
            Icon(
              Icons.account_circle_outlined,
              size: 100,
            ),
            spacing(50),
            Text(
              "Giriş Ekranı",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            spacing(100),
            
            Text(
              "Google ile giriş yap",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            spacing(20),
            //Inkwell efekti tam çalışmıyor
            Material(
              borderRadius: BorderRadius.circular(10),
              //Iconbutonla yap
              color: Colors.grey[350],
              child: 
                  InkWell(
                    onTap: (){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage())
                      );
                    },
                  borderRadius: BorderRadius.circular(5),
                  child: 
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Image.asset(
                      "assets/images/google.png",
                      width: 50,
                    ),
                  ),
                ),
            ),
            spacing(100),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
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
            ),
            spacing(20),
            Text(
              "Kayıt ol",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16
              ),
            ),
            spacing(75)
          ],
        ),
      ),
    );
  }

SizedBox spacing(double size) => SizedBox(height: size,);

Expanded blackDivider() {
    return Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: Colors.grey[600],
                    )
                );
  }
}