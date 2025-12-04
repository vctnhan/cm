// folder: domain/entities/message.dart

enum MessageStatus { pending, sent, delivered, read }

class MessageEntity {
  final String id;
  final String clientId;
  final String channelId;
  final String senderId;
  final String? text;
  final int createdAt;
  final MessageStatus status;

  const MessageEntity({
    required this.id,
    required this.clientId,
    required this.channelId,
    required this.senderId,
    required this.text,
    required this.createdAt,
    required this.status,
  });

  MessageEntity copyWith({
    String? id,
    required String clientId,
    String? channelId,
    String? senderId,
    String? text,
    int? createdAt,
    MessageStatus? status,
  }) {
    return MessageEntity(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      channelId: channelId ?? this.channelId,
      senderId: senderId ?? this.senderId,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }
}
