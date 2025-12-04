import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/message_list.dart';
import 'chat_viewmodel_provider.dart';

class ChatPage extends ConsumerWidget {
  final String chatId;
  final String userId;

  const ChatPage({super.key, required this.chatId, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.read(chatViewModelProvider.notifier);

    return MessageList(
      stream: vm.watchMessages(chatId), // Stream<List<Message>>
      userId: userId,
    );
  }
}
