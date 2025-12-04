// folder: data/models/message_model.dart
import '../../domain/entities/message.dart';

class MessageModel {
  final String id;
  final String clientId;
  final String channelId;
  final String senderId;
  final String? text;
  final int createdAt;
  final MessageStatus status;

  const MessageModel({
    required this.id,
    required this.clientId,
    required this.channelId,
    required this.senderId,
    this.text,
    required this.createdAt,
    this.status = MessageStatus.pending,
  });

  // Convert Model -> Domain
  MessageEntity toEntity() => MessageEntity(
    id: id,
    clientId: clientId,
    channelId: channelId,
    senderId: senderId,
    text: text,
    createdAt: createdAt,
    status: status,
  );

  // Convert Domain -> Model
  factory MessageModel.fromEntity(MessageEntity e, {required String clientId}) {
    return MessageModel(
      id: e.id,
      clientId: clientId,
      channelId: e.channelId,
      senderId: e.senderId,
      text: e.text,
      createdAt: e.createdAt,
      status: e.status,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'clientId': clientId,
    'channelId': channelId,
    'senderId': senderId,
    'text': text,
    'createdAt': createdAt,
    'status': status.index,
  };

  factory MessageModel.fromMap(Map<String, dynamic> m) => MessageModel(
    id: m['id'],
    clientId: m['clientId'],
    channelId: m['channelId'],
    senderId: m['senderId'],
    text: m['text'],
    createdAt: m['createdAt'],
    status: MessageStatus.values[m['status'] ?? 0],
  );
}
