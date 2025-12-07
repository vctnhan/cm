// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_tokens.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThemeTokens _$ThemeTokensFromJson(Map<String, dynamic> json) => ThemeTokens(
  primary: (json['primary'] as num?)?.toInt(),
  background: (json['background'] as num?)?.toInt(),
  text: (json['text'] as num?)?.toInt(),
  assetPath: json['assetPath'] as String?,
  iconPath: json['iconPath'] as String?,
  imagePath: json['imagePath'] as String?,
  animationPath: json['animationPath'] as String?,
  logo: json['logo'] as String?,
);

Map<String, dynamic> _$ThemeTokensToJson(ThemeTokens instance) =>
    <String, dynamic>{
      'primary': instance.primary,
      'background': instance.background,
      'text': instance.text,
      'assetPath': instance.assetPath,
      'iconPath': instance.iconPath,
      'imagePath': instance.imagePath,
      'animationPath': instance.animationPath,
      'logo': instance.logo,
    };
