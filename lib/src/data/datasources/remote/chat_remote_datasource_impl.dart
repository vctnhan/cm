import 'dart:async';
import 'chat_remote_datasource.dart';

/// Fake remote implementation (simulate ack)
class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final StreamController<Map<String, dynamic>> _incoming = StreamController.broadcast();

  @override
  void listen(void Function(Map<String, dynamic>) onEvent) {
    _incoming.stream.listen(onEvent);
  }

  @override
  void send(Map<String, dynamic> data) {
    // Simulate server ack for message.send
    if (data['type'] == 'message.send') {
      final dat = data['data'] as Map<String, dynamic>;
      Future.delayed(const Duration(milliseconds: 200), () {
        _incoming.add({
          'type': 'message.ack',
          'data': {
            'clientId': dat['id'],
            'serverId': 'srv_${DateTime.now().millisecondsSinceEpoch}',
            'serverTs': DateTime.now().millisecondsSinceEpoch,
          }
        });
      });

      // optionally broadcast message.new to others (simulate)
      Future.delayed(const Duration(milliseconds: 250), () {
        _incoming.add({
          'type': 'message.new',
          'data': {
            'id': 'srv_msg_${DateTime.now().millisecondsSinceEpoch}',
            'channelId': dat['channelId'],
            'senderId': dat['senderId'],
            'text': dat['text'],
            'createdAt': DateTime.now().millisecondsSinceEpoch,
          }
        });
      });
    }
  }

  @override
  void dispose() {
    _incoming.close();
  }
}
