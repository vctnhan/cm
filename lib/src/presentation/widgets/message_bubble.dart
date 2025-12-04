import 'package:flutter/material.dart';
import '../../domain/entities/message.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  final MessageEntity message;
  final bool isMe;

  const MessageBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    final time = DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(int.parse(message.createdAt.toString())));
    final color = isMe ? Colors.blue[300] : Colors.grey[300];
    final align = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius = isMe
        ? BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          )
        : BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          );

    Widget statusWidget(MessageStatus st) {
      switch (st) {
        case MessageStatus.pending:
          return Icon(Icons.access_time, size: 12);
        case MessageStatus.sent:
          return Icon(Icons.check, size: 12);
        case MessageStatus.delivered:
          return Icon(Icons.done_all, size: 12);
        case MessageStatus.read:
          return Icon(Icons.done_all, color: Colors.blue, size: 12);
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: align,
        children: [
          Row(
            mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isMe) SizedBox(width: 8),
              Flexible(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: radius,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (message.text != null)
                        Text(message.text!, style: TextStyle(fontSize: 15)),
                      SizedBox(height: 6),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(time, style: TextStyle(fontSize: 11, color: Colors.black54)),
                          SizedBox(width: 6),
                          if (isMe) statusWidget(message.status),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              if (isMe) SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}
