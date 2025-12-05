// features/home/state/home_state.dart

import 'package:chipmunk/src/domain/entities/message.dart';

import '../base/base_state.dart';

class HomeState extends BaseState {
  final List<MessageEntity> messages;

  const HomeState({
    super.isLoading = false,
    super.errorMessage,
    this.messages = const [],
  });

  @override
  HomeState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<MessageEntity>? messages,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      messages: messages ?? this.messages,
    );
  }
}
