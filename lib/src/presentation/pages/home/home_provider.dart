import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_state.dart';
import 'home_viewmodel.dart';

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, HomeState>((
    ref,
    ) {
  return HomeViewModel();
});
