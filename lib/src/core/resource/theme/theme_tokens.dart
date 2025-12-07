import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';

part 'theme_tokens.g.dart';

@JsonSerializable()
class ThemeTokens {
  int? primary;
  int? background;
  int? text;
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
  factory ThemeTokens.fromJson(Map<String, dynamic> json) =>
      _$ThemeTokensFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ThemeTokensToJson(this);
}

// class ThemeTokens {
//   Color? primary;
//   Color? background;
//   Color? text;
//   String? assetPath; // folder gốc
//   String? iconPath; // folder icon
//   String? imagePath; // folder image
//   String? animationPath; // folder lottie/svgs
//   String? logo; // file logo theo theme
//
//   ThemeTokens({
//     this.primary,
//     this.background,
//     this.text,
//     this.assetPath,
//     this.iconPath,
//     this.imagePath,
//     this.animationPath,
//     this.logo,
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       'primary': primary?.value,
//       'background': background?.value,
//       'text': text?.value,
//       'assetPath': assetPath,
//       'iconPath': iconPath,
//       'imagePath': imagePath,
//       'animationPath': animationPath,
//       'logo': logo,
//     };
//   }
//
//   factory ThemeTokens.fromJson(Map<String, dynamic> json) {
//     return ThemeTokens(
//       primary: json['primary'] != null ? Color(json['primary']) : null,
//       background: json['background'] != null ? Color(json['background']) : null,
//       text: json['text'] != null ? Color(json['text']) : null,
//       assetPath: json['assetPath'],
//       iconPath: json['iconPath'],
//       imagePath: json['imagePath'],
//       animationPath: json['animationPath'],
//       logo: json['logo'],
//     );
//   }
// }
