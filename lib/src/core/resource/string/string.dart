import 'package:flutter_riverpod/flutter_riverpod.dart';

final localeProvider = StateProvider<LocaleEntity>((ref) {
  return AppStrings.vi;
});

class AppStrings {
  static const vi = LocaleEntity(
    hello: "Xin chào",
    send: "Gửi",
    message: "Tin nhắn",
  );

  static const en = LocaleEntity(
    hello: "Hello",
    send: "Send",
    message: "Message",
  );
}

class LocaleEntity {
  final String hello;
  final String send;
  final String message;

  const LocaleEntity({
    required this.hello,
    required this.send,
    required this.message,
  });
}
