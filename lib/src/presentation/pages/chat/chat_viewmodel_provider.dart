
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../home/home_state.dart';
import '../home/home_viewmodel.dart';
import 'chat_state.dart';
import 'chat_viewmodel.dart';
import '../../../injection/chat_repository_provider.dart';

final chatViewModelProvider =
StateNotifierProvider<ChatViewModel, ChatState>((ref) {
  final repo = ref.watch(chatRepositoryProvider);
  return ChatViewModel(repo);
});
