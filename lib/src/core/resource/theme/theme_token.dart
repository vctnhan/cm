import 'package:flutter/material.dart';

// @jsonSerializable
class ThemeTokens {
  Color? primary;
  Color? background;
  Color? text;
  String? assetPath; // folder gốc
  String? iconPath; // folder icon
  String? imagePath; // folder image
  String? animationPath; // folder lottie/svgs
  String? logo; // file logo theo theme

  ThemeTokens({
    this.primary,
    this.background,
    this.text,
    this.assetPath,
    this.iconPath,
    this.imagePath,
    this.animationPath,
    this.logo,
  });
}
