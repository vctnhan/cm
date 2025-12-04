import 'package:chipmunk/src/data/datasources/local/chat_local_datasource_impl.dart';
import 'package:chipmunk/src/data/datasources/remote/chat_remote_datasource_impl.dart';
import 'package:chipmunk/src/domain/entities/message.dart';
import 'package:riverpod/riverpod.dart';

import '../data/repositories/chat_repository_impl.dart';
import '../domain/repositories/chat_repository.dart';



final chatLocalProvider = Provider((ref) => ChatLocalDataSourceImpl());
final chatRemoteProvider = Provider((ref) => ChatRemoteDataSourceImpl());

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepositoryImpl(
    ref.watch(chatLocalProvider),
    ref.watch(chatRemoteProvider),
  );
});

final chatStreamProvider = StreamProvider.autoDispose.family<List<MessageEntity>, String>((ref, chatId) {
  final repo = ref.watch(chatRepositoryProvider);
  return repo.watchMessages(chatId); // Stream<List<Message>>
});
