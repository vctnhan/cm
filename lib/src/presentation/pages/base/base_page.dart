import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/resource/theme/app_theme.dart';
import '../../../core/resource/theme/theme_token.dart';

class BasePage extends ConsumerWidget {
  final String title;
  final Widget Function(ThemeTokens theme, WidgetRef ref) builder;

  const BasePage({
    super.key,
    required this.title,
    required this.builder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = ref.watch(themeProvider); // <-- dùng 1 chỗ duy nhất

    return Scaffold(
      backgroundColor: themeNotifier.value.background,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: themeNotifier.value.primary,
      ),
      body: builder(themeNotifier.value, ref),
    );
  }
}
