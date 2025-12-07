import 'package:chipmunk/src/core/resource/theme/theme_tokens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final themeProvider = StateProvider<ThemeTokens>((ref) {
//   return AppThemes.light;
// });
ValueNotifier<ThemeTokens> themeNotifier = ValueNotifier(
    AppThemes.light
);

class AppThemes {
  // Theme mặc định
  static final ThemeTokens light = ThemeTokens(
    primary: Colors.blue.value,
    background: Colors.white.value,
    text: Colors.black.value,
    assetPath: "assets/light",
    iconPath: "assets/light/icons",
    imagePath: "assets/light/images",
    animationPath: "assets/light/animations",
    logo: "assets/light/logo.png",
  );

  // Theme Dark
  static final ThemeTokens dark = ThemeTokens(
    primary: Colors.blueGrey.value,
    background: Colors.orange.value,
    text: Colors.white.value,
    assetPath: "assets/dark",
    iconPath: "assets/dark/icons",
    imagePath: "assets/dark/images",
    animationPath: "assets/dark/animations",
    logo: "assets/dark/logo.png",
  );

  // Theme custom – ví dụ Halloween
  static final ThemeTokens halloween = ThemeTokens(
    primary: Colors.orange.value,
    background: Colors.orange.value,
    text: Colors.white.value,
    assetPath: "assets/halloween",
    iconPath: "assets/halloween/icons",
    imagePath: "assets/halloween/images",
    animationPath: "assets/halloween/animations",
    logo: "assets/halloween/logo_pumpkin.png",
  );
}
