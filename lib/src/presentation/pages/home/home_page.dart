// Importing the Flutter Material package which contains all the UI components needed.
import 'dart:convert';
import 'dart:math';
import 'package:chipmunk/src/presentation/extensions/extensions.dart';
import 'package:chipmunk/src/presentation/extensions/extensions.dart';
import 'package:uuid/uuid.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chipmunk/src/core/helpers/logger.dart';
import 'package:chipmunk/src/domain/entities/message.dart';
import 'package:chipmunk/src/presentation/widgets/chat_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/resource/theme/app_theme.dart';
import '../../../core/resource/theme/theme_tokens.dart';
import 'home_provider.dart';

// The main() function is the entry point of the Flutter application.
void main() => runApp(
  const ProviderScope(child: const MyApp()),
); // Launches the app by running MyApp widget.

// Creating a stateless widget which is the root of the application.
class MyApp extends ConsumerWidget {
  const MyApp({super.key}); // Constructor with optional key.

  // The build method describes the widget tree.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ValueListenableBuilder(
      valueListenable: themeNotifier,
      builder: (context, value, child) {
        return MaterialApp(
          title: "ListView.builder",
          // Title of the application.
          theme: ThemeData(
            primarySwatch: Colors.green,
            primaryColor: "#241A10".toColor(),
          ),
          // App theme with green as primary color.
          debugShowCheckedModeBanner: false,
          // Hides the debug banner in the top-right corner.

          // Sets the home screen to ListViewBuilder widget.
          // Note: No need to use the `new` keyword in modern Dart.
          home: MyHomePage(title: 'hehehe'),
        );
      },
    );
  }
}

class MyHomePage extends ConsumerWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);
    final vm = ref.read(homeViewModelProvider.notifier);

    ref.listen(homeViewModelProvider, (prev, next) {
      if (prev?.messages.length != next.messages.length) {
        // Scroll xuống cuối danh sách
        Future.delayed(const Duration(milliseconds: 50), () {
          if (_controller.hasClients) {
            _controller.animateTo(
              _controller.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      }
    });
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            FloatingActionButton(
              onPressed: () {
                // String jsonString = jsonEncode(AppThemes.halloween.toJson());
                // Logger.log("JSON: $jsonString");
                //
                // // Decode về Map, rồi convert sang ThemeTokens
                // Map<String, dynamic> jsonMap = jsonDecode(jsonString);
                // ThemeTokens newTheme = ThemeTokens.fromJson(jsonMap);
print("123123123");
                final newTheme = ThemeTokens.fromJson(
                  AppThemes.halloween.toJson(),
                );
                themeNotifier.value = newTheme;
              },
              child: Text("sdfsdfsdf"),
            ),
            Expanded(
              child: ListView.builder(
                controller: _controller,
                padding: const EdgeInsets.symmetric(vertical: 8),
                // reverse: true, // Nếu muốn tin nhắn mới nằm dưới cùng
                itemCount: state.messages.length,
                itemBuilder: (_, index) {
                  final message = state.messages[index];
                  // return CustomItem(content: message, isMe: true);
                  return CustomItem2(content: message);
                },
              ),
            ),
            // Expanded(
            //   child: ListView.builder(
            //     controller: _controller,
            //     padding: const EdgeInsets.symmetric(vertical: 8),
            //     // reverse: true, // Nếu muốn tin nhắn mới nằm dưới cùng
            //     itemCount: 1000000,
            //     itemBuilder: (_, index) {
            //       final message = MessageEntity(
            //         id: const Uuid().v7(),
            //         clientId: "",
            //         channelId: "",
            //         senderId: "senderId",
            //         text: "Fake message số $index",
            //         createdAt: 0,
            //         status: MessageStatus.sent,
            //       );
            //
            //       return CustomItem2(content: message);
            //     },
            //   ),
            // ),
            // Thanh nhập tin nhắn
            ChatInput(
              onSend: (input) {
                final item = MessageEntity(
                  id: Uuid().v7(),
                  clientId: "",
                  channelId: "",
                  senderId: "senderId",
                  text: input,
                  createdAt: DateTime.now().millisecondsSinceEpoch,
                  status: MessageStatus.pending,
                );

                vm.addMessage(item);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Defining a stateless widget named ListViewBuilder.

class CustomItem extends ConsumerWidget {
  final MessageEntity content;
  final bool isMe;

  const CustomItem({super.key, required this.content, required this.isMe});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            decoration: BoxDecoration(
              color: isMe ? Colors.blueAccent.shade100 : Colors.grey.shade300,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(14),
                topRight: const Radius.circular(14),
                bottomLeft: isMe
                    ? const Radius.circular(14)
                    : const Radius.circular(0),
                bottomRight: isMe
                    ? const Radius.circular(0)
                    : const Radius.circular(14),
              ),
            ),
            child: Text(
              content.text ?? "",
              style: TextStyle(
                color: isMe ? themeNotifier.value.primary!.toColor() :"#241A10".toColor(),
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomItem2 extends StatelessWidget {
  final MessageEntity content;

  const CustomItem2({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("rebuild r ne");
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.person),
          const SizedBox(width: 10),
          // Fix: Wrap Column with Expanded
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(content.text ?? ""),
                // Text("Subtitle"),
                // CachedNetworkImage(
                //   imageUrl:
                //   "https://cdn2.fptshop.com.vn/unsafe/Uploads/images/tin-tuc/172740/Originals/background-la-gi-1.jpg",
                //   height: 120,
                //   width: double.infinity,
                //   fit: BoxFit.cover,
                //   placeholder: (context, url) =>
                //       Container(
                //         height: 120,
                //         color: Colors.grey[300], // placeholder tĩnh nhẹ
                //       ),
                //   errorWidget: (context, url, error) => Icon(Icons.error),
                // ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}

class ListViewBuilder extends StatefulWidget {
  const ListViewBuilder({Key? key})
    : super(key: key); // Constructor with optional key.

  @override
  State<StatefulWidget> createState() {
    return ListViewState();
  }
}

//
class ListViewState extends State<ListViewBuilder> {
  final itemList = List.generate(
    1000,
    (index) => MessageEntity(
      id: Uuid().v7(),
      clientId: "",
      channelId: "",
      senderId: "senderId",
      text: "text",
      createdAt: 0,
      status: MessageStatus.pending,
    ),
  );
  final ScrollController _scrollController = ScrollController();

  void addItem(String content) {
    setState(() {
      final item = MessageEntity(
        id: Uuid().v7(),
        clientId: "",
        channelId: "",
        senderId: "senderId",
        text: "text",
        createdAt: 0,
        status: MessageStatus.pending,
      );
      print("addd r ne");
      itemList.insert(0, item);
    });
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      controller: _scrollController,

      // scroll kiểu iOS, có thể dùng trên Android
      itemCount: itemList.length,
      itemBuilder: (context, index) {
        return RepaintBoundary(
          child: CustomItem(
            key: ValueKey("${itemList[index]}_$index"),
            content: itemList[index],
            isMe: true,
          ),
        );
      },
    );
  }
}
