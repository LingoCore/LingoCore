import 'package:flutter/material.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  // Sample chat messages (question and answer pairs)
  final List<Map<String, String>> messages = [
    {
      'text': 'Merhaba, nasılsın?',
      'type': 'question',
      'time': '10:00'
    },
    {
      'text': 'Merhaba! Ben bir yapay zeka asistanıyım. Size nasıl yardımcı olabilirim?',
      'type': 'answer',
      'time': '10:01'
    },
  ];

  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      // Add user question
      messages.add({
        'text': _messageController.text,
        'type': 'question',
        'time': '${DateTime.now().hour}:${DateTime.now().minute}'
      });
      
      // Clear input field
      _messageController.clear();
      
      // Simulate AI response after a short delay
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          messages.add({
            'text': 'Bu bir simüle edilmiş cevaptır. API bağlantısı kurulduğunda gerçek cevaplar alacaksınız.',
            'type': 'answer',
            'time': '${DateTime.now().hour}:${DateTime.now().minute}'
          });
        });
        
        // Scroll to bottom
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    });
    
    // Scroll to bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: messages.isEmpty
                  ? const Center(
                      child: Text('Henüz mesaj yok'),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final isQuestion = message['type'] == 'question';
                        
                        return Align(
                          alignment: isQuestion
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isQuestion
                                  ? Colors.blue[100]
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(12),
                                topRight: const Radius.circular(12),
                                bottomLeft: isQuestion
                                    ? const Radius.circular(12)
                                    : Radius.zero,
                                bottomRight: isQuestion
                                    ? Radius.zero
                                    : const Radius.circular(12),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: isQuestion
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Text(message['text']!),
                                const SizedBox(height: 4),
                                Text(
                                  message['time']!,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Mesaj yaz...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onSubmitted: (value) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _sendMessage,
              borderRadius: BorderRadius.circular(24), // half the button size
              splashColor: Colors.blue[900], // touch color effect
              hoverColor: Colors.blue[800], // hover color
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_upward_rounded, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}