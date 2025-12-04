// features/home/state/home_state.dart

import '../base/base_state.dart';

class HomeState extends BaseState {
  final List<String> messages;

  const HomeState({
    super.isLoading = false,
    super.errorMessage,
    this.messages = const [],
  });

  @override
  HomeState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<String>? messages,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      messages: messages ?? this.messages,
    );
  }
}
