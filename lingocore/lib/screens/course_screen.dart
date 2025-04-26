import 'package:flutter/material.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  
  final List<String> lessons = List.generate(20, (index) => 'Ders ${index + 1}');
  final List<String> lessonDescription = List.generate(20, (index) => 'Bu ${index + 1}. dersin içeriğidir.');
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // to prevent the application from slowing down as the number of lessons increases.
      body: ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, index) {

          final lessonTitle = lessons[index];
          final lessonsDescription = lessonDescription[index];

          return Container(
            // width: 300,
            // height: 100,
            padding: EdgeInsets.all(50),
            margin: EdgeInsets.all(100),
            alignment: Alignment.center, // to center the text
            decoration: BoxDecoration( // to customize the container
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 4, color: Colors.black26), // frame
              gradient: LinearGradient( // renk geçişli görünüm sağlar.
                colors: [Colors.blue, Colors.white], 
                begin: Alignment.topLeft, 
                end: Alignment.bottomRight,
                ),
    
              boxShadow: [ // Gölgelendirmek için
                BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 6, // rengi belirginleştirmek için (bulanıklık değeri)
                spreadRadius: 1, // rengi daha fazla yaymak için (yayılma değeri)
                offset: Offset(0,2), // üstten güneş vurmuş gibi bir efekt bırakıyor
                ),
              ] 
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                child: Text('${index + 1}'),
              ),

              title: Text(lessonTitle),
              subtitle: Text(lessonsDescription),
              trailing: Icon(Icons.arrow_forward_ios),

              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => LessonDetailPage(lessonTitle: lessonTitle),
                  )
                );
              },
            ),
          );
            

          
        }
      ),
    );
  }
}


class LessonDetailPage extends StatelessWidget {
  
  // lesson title from previous page
  final String lessonTitle; 

  // Constructor: Requires the course title to be retrieved when creating this page
  const LessonDetailPage({Key? key, required this.lessonTitle}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lessonTitle),
      ),
      body: Center(

        child: Text(
          'Bu sayfa "$lessonTitle" içeriğini gösterecektir.\n\nBuraya video, metin, alıştırmalar vb. ekleyebilirsiniz.',
          style: TextStyle(fontSize: 19.0),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}