import 'package:flutter/material.dart';
import 'package:lingocore/lesson_pages.dart';

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
          const double maxContentWidth = 600.0; // to prevents content from becoming excessively fragmented on very wide screens.

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Center(
              child: InkWell(
                // to make sure the Ripple effect to appear properly.
                borderRadius: BorderRadius.circular(20), 
                onTap: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => LessonPages(),
                    )
                  );
                },
                child: ConstrainedBox( // sets a maximum width limit on the content.
                  constraints: const BoxConstraints( 
                    maxWidth: maxContentWidth),
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration( // to customize the container
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 4, color: Colors.black26), // frame
                      gradient: LinearGradient(  // provides a color transition appearance.
                        colors: [Colors.blue, Colors.white], 
                        begin: Alignment.topLeft, 
                        end: Alignment.bottomRight,
                        ),
                  
                      // to shade
                      boxShadow: [ 
                        BoxShadow(
                        color: Colors.grey.shade500,
                        blurRadius: 8, // to highlight the color (blur value)
                        spreadRadius: 2, // to spread the color more (spread value)
                        offset: Offset(0,3), // gives an effect as if the sun hit from above.
                        ),
                      ] 
                    ),
                    child: ListTile(
                      // This parameter was added because the ListTile widget overrides the clickable hand icon in the container.
                      mouseCursor: SystemMouseCursors.click, 
                      leading: ClipOval(
                        child: Container(
                          width: 40.0, // A value close to the default diameter of the CircleAvatar (radius=20)
                          height: 40.0, // Width and height must be the same to make it a circle
                          color: Colors.blueAccent, 
                          alignment: Alignment.center, 
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: Colors.white, 
                            ),
                          ),
                        ),
                      ),
                      title: Text(lessonTitle),
                      subtitle: Text(lessonsDescription),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
