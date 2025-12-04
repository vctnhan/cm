import 'package:flutter/material.dart';
import '../../domain/entities/message.dart';
import 'message_bubble.dart';

class MessageList extends StatefulWidget {
  final Stream<List<MessageEntity>> stream;
  final String userId;

  const MessageList({
    super.key,
    required this.stream,
    required this.userId,
  });

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  final ScrollController _controller = ScrollController();
  List<MessageEntity> _oldMessages = [];

  void _scrollToBottom() {
    if (!_controller.hasClients) return;

    _controller.animateTo(
      0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MessageEntity>>(
      stream: widget.stream,
      initialData: const [],
      builder: (context, snapshot) {
        final messages = snapshot.data ?? [];

        // Auto scroll chỉ khi có tin nhắn mới
        if (messages.length != _oldMessages.length) {
          WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
          _oldMessages = List.from(messages);
        }

        if (messages.isEmpty) {
          return const Center(child: Text("No messages yet"));
        }

        return ListView.builder(
          controller: _controller,
          reverse: true, // newest at bottom
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final m = messages[index];
            final isMe = m.senderId == widget.userId;

            return MessageBubble(
              key: ValueKey(m.id),
              message: m,
              isMe: isMe,
            );
          },
        );
      },
    );
  }
}
