import 'package:flutter/material.dart';
import 'package:lingocore/dialogs/userinfo.dart';
import 'package:lingocore/screens/ai_chat.dart';
import 'package:lingocore/screens/course.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int currentPage = 1;
  var pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("LingoCore"),
        actions: [
          IconButton(
            style: IconButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => UserInfoDialog(),
              );
            },
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: PageView(
        controller: pageController,
        scrollDirection: Axis.horizontal,
        onPageChanged:
            (value) => setState(() {
              currentPage = value;
            }),
        children: [
          AiChatScreen(),
          CourseScreen(),
          Container(
            color: Colors.blue[50],
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [Text("GENEL CHAT"), Icon(Icons.chat_outlined)],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
          if (pageController.page != currentPage) {
            pageController.animateToPage(
              currentPage,
              duration: Durations.short2,
              curve: Curves.ease,
            );
          }
        },
        currentIndex: currentPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome_sharp),
            label: "AI",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.class_), label: "Ders"),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_rounded),
            label: "Chat",
          ),
        ],
      ),
    );
  }
}
