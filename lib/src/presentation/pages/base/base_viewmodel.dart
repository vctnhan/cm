// core/base/base_viewmodel.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'base_state.dart';

class BaseViewModel<T extends BaseState> extends StateNotifier<T> {
  BaseViewModel(T state) : super(state);

  void setLoading(bool value) {
    state = state.copyWith(isLoading: value) as T;
  }

  void setError(String? error) {
    state = state.copyWith(errorMessage: error) as T;
  }
}
