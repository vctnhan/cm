import 'dart:async';

import '../../../domain/entities/message.dart';
import 'chat_local_datasource.dart';

class ChatLocalDataSourceImpl implements ChatLocalDataSource {
  final Map<String, List<MessageEntity>> _store = {};
  final Map<String, StreamController<List<MessageEntity>>> _controllers = {};

  Stream<List<MessageEntity>> watchMessages(String channelId) {
    /*--> UI cần danh sách tin nhắn hiện tại (từ _store)*/
    _controllers.putIfAbsent(channelId, () => StreamController<List<MessageEntity>>.broadcast());
    _store.putIfAbsent(channelId, () => []);
    return _controllers[channelId]!.stream;
  }

  Future<void> saveMessage(MessageEntity message) async {
    /*--> add vào _store
--> _controllers[channelA].add(list mới)  -> UI update*/
    final list = _store.putIfAbsent(message.channelId, () => []);
    list.add(message);
    _controllers.putIfAbsent(message.channelId, () => StreamController<List<MessageEntity>>.broadcast());
    _controllers[message.channelId]!.add(List.unmodifiable(list));
  }

  Future<void> updateMessageByClientId(String clientId, MessageEntity updated) async {
  /*  --> sửa message trong _store
    --> bắn lại qua _controllers*/
    for (final entry in _store.entries) {
      final idx = entry.value.indexWhere((m) => m.clientId == clientId);
      if (idx >= 0) {
        entry.value[idx] = updated;
        _controllers.putIfAbsent(entry.key, () => StreamController<List<MessageEntity>>.broadcast());
        _controllers[entry.key]!.add(List.unmodifiable(entry.value));
        return;
      }
    }
  }

  Future<void> dispose() async {
    for (final c in _controllers.values) {
      await c.close();
    }
    _controllers.clear();
    _store.clear();
  }
}
