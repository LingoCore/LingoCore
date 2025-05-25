import 'package:flutter/material.dart';
import 'package:lingocore/services/theme.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  // Sample chat messages (question and answer pairs)
  final List<Map<String, String>> messages = [
    {'text': 'Merhaba, nasılsın?', 'type': 'question', 'time': '10:00'},
    {
      'text':
          'Merhaba! Ben bir yapay zeka asistanıyım. Size nasıl yardımcı olabilirim?',
      'type': 'answer',
      'time': '10:01',
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
        'time':
            '${DateTime.now().hour.toString().padLeft(2, "0")}'
            ':'
            '${DateTime.now().minute.toString().padLeft(2, "0")}',
      });

      // Clear input field
      _messageController.clear();

      // Simulate AI response after a short delay
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          messages.add({
            'text':
                'Bu bir simüle edilmiş cevaptır. API bağlantısı kurulduğunda gerçek cevaplar alacaksınız.',
            'type': 'answer',
            'time': '${DateTime.now().hour}:${DateTime.now().minute}',
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
              child:
                  messages.isEmpty
                      ? const Center(child: Text('Henüz mesaj yok'))
                      : ListView.builder(
                        controller: _scrollController,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          final isQuestion = message['type'] == 'question';

                          return Align(
                            alignment:
                                isQuestion
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 8,
                              ),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color:
                                    isQuestion
                                        ? Theme.of(context).colorScheme.primary
                                        : getFlavour(context).surface0,
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(12),
                                  topRight: const Radius.circular(12),
                                  bottomLeft:
                                      isQuestion
                                          ? const Radius.circular(12)
                                          : Radius.zero,
                                  bottomRight:
                                      isQuestion
                                          ? Radius.zero
                                          : const Radius.circular(12),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment:
                                    isQuestion
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    message['text']!,
                                    style: TextStyle(
                                      color:
                                          isQuestion
                                              ? Theme.of(
                                                context,
                                              ).colorScheme.onPrimary
                                              : Theme.of(
                                                context,
                                              ).colorScheme.onSurface,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    message['time']!,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color:
                                          isQuestion
                                              ? Theme.of(
                                                context,
                                              ).colorScheme.onPrimary
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .onSurface
                                                  .withValues(alpha: 0.6),
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
                fillColor: getFlavour(context).surface0,
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
            color: Theme.of(context).colorScheme.primary,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: _sendMessage,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  // color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_upward_rounded,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
