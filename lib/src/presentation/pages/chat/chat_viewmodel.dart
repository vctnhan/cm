import '../../../domain/entities/message.dart';
import '../../../domain/repositories/chat_repository.dart';
import '../base/base_viewmodel.dart';
import 'chat_state.dart';

class ChatViewModel extends BaseViewModel<ChatState> {
  final ChatRepository repo;
  ChatViewModel(this.repo) : super(const ChatState());

  Stream<List<MessageEntity>> watchMessages(String channelId) {
    return repo.watchMessages(channelId);
  }

  Future<void> send(String channelId, String text, String userId) async {
    try {
      setLoading(true);

      final clientId = 'cli_${DateTime.now().millisecondsSinceEpoch}';
      final msg = MessageEntity(
        id: clientId,
        clientId: clientId,
        channelId: channelId,
        senderId: userId,
        text: text,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        status: MessageStatus.pending,
      );

      await repo.sendMessage(msg);
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }
}
