import 'package:flutter/material.dart';
import 'dart:math';

class Message {
  final String text;
  final DateTime date;
  final bool isMe;
  final String username;

  const Message({
    required this.text,
    required this.date,
    required this.isMe,
    required this.username,
  });
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with AutomaticKeepAliveClientMixin {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<Message> messages = [];
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final Map<String, Color> _usernameColors = {};
  final Random _random = Random();

  @override
  void initState() {
    super.initState();

    // Başlangıç mesajlarını eklemek için:
      messages = [
      Message(text: "Hello everyone!", date: DateTime(2025, 5, 1, 9, 0), isMe: false, username: "Alice"),
      Message(text: "Hi Alice!", date: DateTime(2025, 5, 1, 9, 5), isMe: true, username: "Me"),
      Message(text: "Good morning!", date: DateTime(2025, 5, 1, 9, 10), isMe: false, username: "Bob"),
      Message(text: "How's everyone doing?", date: DateTime(2025, 5, 1, 9, 15), isMe: false, username: "Charlie"),
      Message(text: "I'm doing great, thanks!", date: DateTime(2025, 5, 1, 9, 20), isMe: true, username: "Me"),
      Message(text: "What about you?", date: DateTime(2025, 5, 1, 9, 25), isMe: false, username: "Alice"),
      Message(text: "Just working on a project.", date: DateTime(2025, 5, 2, 10, 0), isMe: true, username: "Me"),
      Message(text: "Sounds interesting!", date: DateTime(2025, 5, 2, 10, 15), isMe: false, username: "Bob"),
      Message(text: "Yeah, it is!", date: DateTime(2025, 5, 2, 10, 20), isMe: true, username: "Me"),
      Message(text: "Do you need any help?", date: DateTime(2025, 5, 3, 11, 0), isMe: false, username: "Charlie"),
      Message(text: "Not right now, but thanks!", date: DateTime(2025, 5, 3, 11, 5), isMe: true, username: "Me"),
      Message(text: "Let me know if you do.", date: DateTime(2025, 5, 3, 11, 10), isMe: false, username: "Alice"),
      Message(text: "Sure, will do!", date: DateTime(2025, 5, 3, 11, 15), isMe: true, username: "Me"),
      Message(text: "How's the weather there?", date: DateTime(2025, 5, 4, 12, 0), isMe: false, username: "Bob"),
      Message(text: "It's sunny and warm.", date: DateTime(2025, 5, 4, 12, 5), isMe: true, username: "Me"),
      Message(text: "Lucky you! It's raining here.", date: DateTime(2025, 5, 4, 12, 10), isMe: false, username: "Charlie"),
      Message(text: "Oh no, stay dry!", date: DateTime(2025, 5, 4, 12, 15), isMe: true, username: "Me"),
      Message(text: "Will do, thanks!", date: DateTime(2025, 5, 5, 13, 0), isMe: false, username: "Alice"),
      Message(text: "Any plans for the weekend?", date: DateTime(2025, 5, 5, 13, 5), isMe: false, username: "Bob"),
      Message(text: "Not yet, you?", date: DateTime(2025, 5, 5, 13, 10), isMe: true, username: "Me"),
      Message(text: "Thinking of going hiking.", date: DateTime(2025, 5, 5, 13, 15), isMe: false, username: "Charlie"),
      Message(text: "That sounds fun!", date: DateTime(2025, 5, 5, 13, 20), isMe: true, username: "Me"),
      Message(text: "Yeah, I hope the weather stays good.", date: DateTime(2025, 5, 6, 14, 0), isMe: false, username: "Alice"),
      Message(text: "Fingers crossed!", date: DateTime(2025, 5, 6, 14, 5), isMe: true, username: "Me"),
      Message(text: "What about you?", date: DateTime(2025, 5, 6, 14, 10), isMe: false, username: "Bob"),
      Message(text: "Might just relax at home.", date: DateTime(2025, 5, 6, 14, 15), isMe: true, username: "Me"),
      Message(text: "That sounds nice too.", date: DateTime(2025, 5, 6, 14, 20), isMe: false, username: "Charlie"),
      Message(text: "Yeah, I need a break.", date: DateTime(2025, 5, 7, 15, 0), isMe: true, username: "Me"),
      Message(text: "Take care!", date: DateTime(2025, 5, 7, 15, 5), isMe: false, username: "Alice"),
      Message(text: "You too!", date: DateTime(2025, 5, 7, 15, 10), isMe: true, username: "Me"),
    ];

    // AnimatedList'a başta mesajları animasyonla eklemek için:
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (var i = 0; i < messages.length; i++) {
        _listKey.currentState?.insertItem(i, duration: const Duration(milliseconds: 300));
      }
      _scrollToBottom();
    });
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      final newMessage = Message(
        text: text,
        date: DateTime.now(),
        isMe: true,
        username: "Me",
      );
      setState(() {
        messages.add(newMessage);
        _listKey.currentState?.insertItem(messages.length - 1, duration: const Duration(milliseconds: 300));
      });
      _messageController.clear();

      // Animasyonun bitmesini bekleyip sonra kaydır
      Future.delayed(const Duration(milliseconds: 350), () {
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

  Color _getUsernameColor(String username) {
    if (username == "Me") {
      return Colors.blue;
    }
    if (!_usernameColors.containsKey(username)) {
      _usernameColors[username] = Color.fromARGB(
        255,
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
      );
    }
    return _usernameColors[username]!;
  }

  // Tarih başlığı için yardımcı
  bool _isNewDate(int index) {
    if (index == 0) return true;
    return !isSameDay(messages[index].date, messages[index - 1].date);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // for AutomaticKeepAliveClientMixin

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Chat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: AnimatedList(
              key: _listKey,
              controller: _scrollController,
              initialItemCount: messages.length,
              itemBuilder: (context, index, animation) {
                if (index < 0 || index >= messages.length) {
                  return const SizedBox.shrink(); // Hatalı index için boş widget döndür
                }
                final message = messages[index];

                return SizeTransition(
                  sizeFactor: animation,
                  axisAlignment: 0.0,
                  child: Column(
                    children: [
                      if (_isNewDate(index))
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: Text(
                              _formatDate(message.date),
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      Align(
                        alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          constraints: BoxConstraints(
                            minWidth: 60,
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: message.isMe ? Colors.blue[100] : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                message.username,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: _getUsernameColor(message.username),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                message.text,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
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
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Type your message...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    style: const TextStyle(fontSize: 16),
                    textInputAction: TextInputAction.send,
                    onSubmitted: (value) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  iconSize: 24,
                  color: Colors.blue,
                  padding: const EdgeInsets.all(8),
                  splashRadius: 20,
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  bool get wantKeepAlive => true;
}
