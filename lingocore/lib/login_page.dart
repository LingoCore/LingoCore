import 'package:flutter/material.dart';
//renklere çok uğraşamadım siz ayarlarsınız
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
            SizedBox(height: 75,),
            Text(
              "Giriş Ekranı",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 100,),
            
            Text(
              "Google ile giriş yap",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[350]
              ),
              child: Icon(Icons.add_sharp)
            ),
            SizedBox(height: 100,),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[600],
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "Kayıtlı kullanıcı değil misin?",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[600],
                      )
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Text(
              "Kayıt ol",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16
              ),
            ),
            SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}