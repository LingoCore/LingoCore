import 'package:flutter/material.dart';

class Massage {
  final String text;
  final DateTime date;
  final bool isMe;

  const Massage({required this.text, required this.date, required this.isMe});
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Massage> massages = [];
  final TextEditingController _messageController = TextEditingController(); // Controller for input
  final ScrollController _scrollController = ScrollController(); // Controller for scrolling

  @override
  void initState() {
    super.initState();
    massages = [
      Massage(text: "Hello!", date: DateTime(2025, 5, 1, 9, 0), isMe: false),
      Massage(text: "Hi, how are you?", date: DateTime(2025, 5, 1, 9, 5), isMe: true),
      Massage(text: "I'm good, thanks!", date: DateTime(2025, 5, 1, 9, 10), isMe: false),
      Massage(text: "What about you?", date: DateTime(2025, 5, 1, 9, 15), isMe: false),
      Massage(text: "I'm doing great!", date: DateTime(2025, 5, 1, 9, 20), isMe: true),
      Massage(text: "What are you up to?", date: DateTime(2025, 5, 2, 10, 0), isMe: false),
      Massage(text: "Just working on a project.", date: DateTime(2025, 5, 2, 10, 10), isMe: true),
      Massage(text: "Sounds interesting!", date: DateTime(2025, 5, 2, 10, 15), isMe: false),
      Massage(text: "Yeah, it is!", date: DateTime(2025, 5, 2, 10, 20), isMe: true),
      Massage(text: "Do you need any help?", date: DateTime(2025, 5, 3, 11, 0), isMe: false),
      Massage(text: "Not right now, but thanks!", date: DateTime(2025, 5, 3, 11, 5), isMe: true),
      Massage(text: "Let me know if you do.", date: DateTime(2025, 5, 3, 11, 10), isMe: false),
      Massage(text: "Sure, will do!", date: DateTime(2025, 5, 3, 11, 15), isMe: true),
      Massage(text: "How's the weather there?", date: DateTime(2025, 5, 4, 12, 0), isMe: false),
      Massage(text: "It's sunny and warm.", date: DateTime(2025, 5, 4, 12, 5), isMe: true),
      Massage(text: "Lucky you! It's raining here.", date: DateTime(2025, 5, 4, 12, 10), isMe: false),
      Massage(text: "Oh no, stay dry!", date: DateTime(2025, 5, 4, 12, 15), isMe: true),
      Massage(text: "Will do, thanks!", date: DateTime(2025, 5, 5, 13, 0), isMe: false),
      Massage(text: "Any plans for the weekend?", date: DateTime(2025, 5, 5, 13, 5), isMe: false),
      Massage(text: "Not yet, you?", date: DateTime(2025, 5, 5, 13, 10), isMe: true),
      Massage(text: "Thinking of going hiking.", date: DateTime(2025, 5, 5, 13, 15), isMe: false),
      Massage(text: "That sounds fun!", date: DateTime(2025, 5, 5, 13, 20), isMe: true),
      Massage(text: "Yeah, I hope the weather stays good.", date: DateTime(2025, 5, 6, 14, 0), isMe: false),
      Massage(text: "Fingers crossed!", date: DateTime(2025, 5, 6, 14, 5), isMe: true),
      Massage(text: "What about you?", date: DateTime(2025, 5, 6, 14, 10), isMe: false),
      Massage(text: "Might just relax at home.", date: DateTime(2025, 5, 6, 14, 15), isMe: true),
      Massage(text: "That sounds nice too.", date: DateTime(2025, 5, 6, 14, 20), isMe: false),
      Massage(text: "Yeah, I need a break.", date: DateTime(2025, 5, 7, 15, 0), isMe: true),
      Massage(text: "Take care!", date: DateTime(2025, 5, 7, 15, 5), isMe: false),
      Massage(text: "You too!", date: DateTime(2025, 5, 7, 15, 10), isMe: true),
    ];
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        massages.add(
          Massage(
            text: text,
            date: DateTime.now(),
            isMe: true,
          ),
        );
      });
      _messageController.clear(); // Clear the input field after sending

      // Ensure scrolling happens after the new message is rendered
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Chat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              controller: _scrollController, // Attach the scroll controller
              children: _buildMessagesWithHeaders(),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      filled: true, // Adds a background color
                      fillColor: Colors.grey[200], // Light grey background
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20), // Rounded corners
                        borderSide: BorderSide.none, // Removes the border line
                      ),
                      hintText: 'Type your message...',
                      hintStyle: const TextStyle(color: Colors.grey), // Hint text color
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding inside the field
                    ),
                    style: const TextStyle(fontSize: 16), // Text style for user input
                    textInputAction: TextInputAction.send, // Changes the keyboard action button to "Send"
                    onSubmitted: (value) => _sendMessage(), // Send message on "Enter" key
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  iconSize: 24, // Adjust the size of the icon
                  color: Colors.blue, // Change the color of the icon
                  padding: const EdgeInsets.all(8), // Add padding around the icon
                  splashRadius: 20, // Adjust the splash effect radius
                  onPressed: _sendMessage, // Call the send message method
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMessagesWithHeaders() {
    List<Widget> widgets = [];
    DateTime? lastDate;

    for (var massage in massages) {
      if (lastDate == null || !isSameDay(lastDate, massage.date)) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: Text(
                _formatDate(massage.date),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
        lastDate = massage.date;
      }

      widgets.add(
        Align(
          alignment: massage.isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: massage.isMe ? Colors.blue[100] : Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(massage.text),
          ),
        ),
      );
    }

    return widgets;
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
