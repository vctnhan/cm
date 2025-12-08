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
    primary: "#EB0909",
    background:  "#21D121",
    text:  "#D121D1",
    assetPath: "assets/light",
    iconPath: "assets/light/icons",
    imagePath: "assets/light/images",
    animationPath: "assets/light/animations",
    logo: "assets/light/logo.png",
  );

  // Theme Dark
  static final ThemeTokens dark = ThemeTokens(
    primary: "#241A10",
    background:  "#192E19",
    text:  "#525C52",
    assetPath: "assets/dark",
    iconPath: "assets/dark/icons",
    imagePath: "assets/dark/images",
    animationPath: "assets/dark/animations",
    logo: "assets/dark/logo.png",
  );

  // Theme custom – ví dụ Halloween
  static final ThemeTokens halloween = ThemeTokens(
    primary: "#D4AF83",
    background:  "#2421D1",
    text:  "#2421D1",
    assetPath: "assets/halloween",
    iconPath: "assets/halloween/icons",
    imagePath: "assets/halloween/images",
    animationPath: "assets/halloween/animations",
    logo: "assets/halloween/logo_pumpkin.png",
  );
}
