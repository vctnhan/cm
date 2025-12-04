import 'dart:async';

import '../../../domain/entities/message.dart';


abstract class ChatLocalDataSource {
  Stream<List<MessageEntity>> watchMessages(String channelId);
  Future<void> saveMessage(MessageEntity message);
  Future<void> updateMessageByClientId(String clientId, MessageEntity updated);
  Future<void> dispose();
}
