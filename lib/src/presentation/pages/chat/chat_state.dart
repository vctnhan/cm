// features/home/state/home_state.dart

import '../base/base_state.dart';

class ChatState extends BaseState {
  final List<String> messages;

  const ChatState({
    super.isLoading = false,
    super.errorMessage,
    this.messages = const [],
  });

  @override
  ChatState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<String>? messages,
  }) {
    return ChatState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      messages: messages ?? this.messages,
    );
  }
}
