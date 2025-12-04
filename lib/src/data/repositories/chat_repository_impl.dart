import '../../domain/entities/message.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/local/chat_local_datasource.dart';
import '../datasources/remote/chat_remote_datasource.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatLocalDataSource local;
  final ChatRemoteDataSource remote;
  late final void Function(Map<String, dynamic>) _remoteListener;

  ChatRepositoryImpl(this.local, this.remote) {
    _remoteListener = _handleRemoteEvent;
    remote.listen(_remoteListener);
  }

  @override
  Stream<List<MessageEntity>> watchMessages(String channelId) =>
      local.watchMessages(channelId);

  @override
  Future<void> sendMessage(MessageEntity message) async {
    await local.saveMessage(message);

    remote.send({
      'type': 'message.send',
      'data': {
        'id': message.clientId ?? message.id,
        'channelId': message.channelId,
        'senderId': message.senderId,
        'text': message.text,
        'createdAt': message.createdAt,
      }
    });
  }

  void _handleRemoteEvent(Map<String, dynamic> ev) {
    final type = ev['type'];
    final data = ev['data'] as Map<String, dynamic>?;

    if (type == 'message.ack') {
      final clientId = data?['clientId'];
      final serverId = data?['serverId'];
      final serverTs = data?['serverTs'];

      if (clientId != null && serverId != null && serverTs != null) {
        final updated = MessageEntity(
          id: serverId,
          clientId: clientId,
          channelId: 'general',
          senderId: 'me',
          text: null,
          createdAt: serverTs,
          status: MessageStatus.sent,
        );
        local.updateMessageByClientId(clientId, updated);
      }
    }

    if (type == 'message.new' && data != null) {
      final msg = MessageEntity(
        id: data['id'],
        clientId: DateTime.now().millisecondsSinceEpoch.toString(),
        channelId: data['channelId'],
        senderId: data['senderId'],
        text: data['text'],
        createdAt: data['createdAt'],
        status: MessageStatus.delivered,
      );
      local.saveMessage(msg);
    }
  }

  @override
  Future<void> dispose() async {
    remote.dispose();
    await local.dispose();
  }
}
