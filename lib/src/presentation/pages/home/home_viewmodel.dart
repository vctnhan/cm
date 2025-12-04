// features/home/viewmodel/home_viewmodel.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../base/base_viewmodel.dart';
import 'home_state.dart';


class HomeViewModel extends BaseViewModel<HomeState> {
  HomeViewModel() : super(const HomeState());

  /// Thêm message
  void addMessage() {
    final newList = [...state.messages];
    newList.add("Pos ${DateTime.now().millisecondsSinceEpoch}");

    state = state.copyWith(messages: newList);
  }
}
