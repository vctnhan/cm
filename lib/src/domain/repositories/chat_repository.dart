import '../entities/message.dart';
import 'repository.dart';

abstract class ChatRepository extends IRepo {
  Stream<List<MessageEntity>> watchMessages(String channelId);
  Future<void> sendMessage(MessageEntity message);
  Future<void> dispose();
}
