abstract class ChatRemoteDataSource {
  /// Send data to server (websocket/http)
  void send(Map<String, dynamic> data);

  /// Register listener for incoming events
  void listen(void Function(Map<String, dynamic>) onEvent);

  /// Dispose/close streams and sockets
  void dispose();
}
