import 'dart:async';
import 'dart:convert';
import 'package:uuid/uuid.dart';

typedef SocketCallback = void Function(Map<String, dynamic>);

/// A mock socket service that simulates a realtime server.
/// It supports:
/// - sending events to server (client -> server)
/// - server echoing back message.confirm and broadcasting message.new
/// - typing indicator simulation
class MockSocketService {
  final _inController = StreamController<Map<String, dynamic>>.broadcast();
  final _outController = StreamController<Map<String, dynamic>>.broadcast();
  SocketCallback? onMessage;

  Timer? _incomingTimer;
  final _uuid = Uuid();

  // Client calls this to send data to "server"
  void send(Map<String, dynamic> data) {
    // For demo we process immediately
    _processClientEvent(data);
  }

  // Client subscribes to incoming events
  Stream<Map<String, dynamic>> get incoming => _inController.stream;

  void _processClientEvent(Map<String, dynamic> ev) {
    final type = ev['type'];
    if (type == 'message.send') {
      // simulate server ack + broadcast
      final data = ev['data'] as Map<String, dynamic>;
      // create serverId
      final serverId = _uuid.v4();
      final now = DateTime.now().millisecondsSinceEpoch;

      // send ack to sender
      _inController.add({
        'type': 'message.ack',
        'data': {
          'clientId': data['id'],
          'serverId': serverId,
          'serverTs': now,
        }
      });

      // broadcast new message to all clients (including sender)
      final broadcast = {
        'type': 'message.new',
        'data': {
          'id': serverId,
          'channelId': data['channelId'],
          'senderId': data['senderId'],
          'text': data['text'],
          'createdAt': now,
        }
      };

      // slight delay to simulate network
      Future.delayed(Duration(milliseconds: 200), () {
        _inController.add(broadcast);
      });
    } else if (type == 'typing.start' || type == 'typing.stop') {
      // broadcast typing events
      final broadcast = {
        'type': 'typing',
        'data': ev['data'],
      };
      _inController.add(broadcast);
    }
  }

  /// For demo: periodically emit an incoming message from "another user"
  void startMockServer() {
    _incomingTimer?.cancel();
    _incomingTimer = Timer.periodic(Duration(seconds: 12), (t) {
      final now = DateTime.now().millisecondsSinceEpoch;
      _inController.add({
        'type': 'message.new',
        'data': {
          'id': _uuid.v4(),
          'channelId': 'general',
          'senderId': 'user_bot',
          'text': 'Hello from bot @ ' + DateTime.now().toLocal().toIso8601String(),
          'createdAt': now,
        }
      });
    });
  }

  void dispose() {
    _incomingTimer?.cancel();
    _inController.close();
    _outController.close();
  }
}
