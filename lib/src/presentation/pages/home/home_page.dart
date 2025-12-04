// Importing the Flutter Material package which contains all the UI components needed.
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_provider.dart';

// The main() function is the entry point of the Flutter application.
void main() =>
    runApp(
        const ProviderScope(
          child:const MyApp(),
        ),
    ); // Launches the app by running MyApp widget.

// Creating a stateless widget which is the root of the application.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Constructor with optional key.

  // The build method describes the widget tree.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ListView.builder",
      // Title of the application.
      theme: ThemeData(primarySwatch: Colors.green),
      // App theme with green as primary color.
      debugShowCheckedModeBanner: false,
      // Hides the debug banner in the top-right corner.

      // Sets the home screen to ListViewBuilder widget.
      // Note: No need to use the `new` keyword in modern Dart.
      home: MyHomePage(title: 'hehehe'),
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
    ref.listen(
      homeViewModelProvider,
          (prev, next) {
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
      },
    );
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          controller: _controller,
          // reverse: true,
          itemCount: state.messages.length,
          itemBuilder: (_, index) => CustomItem(content: state.messages[index]),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: vm.addMessage,
        child: Icon(Icons.add),
      ),
    );
  }


}

// class _MyHomePageState extends State<MyHomePage>
// {
//   final GlobalKey<ListViewState> listViewState = GlobalKey<ListViewState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           children: [
//             // 1. ListView chiếm toàn bộ màn hình
//             // Column(
//             //   children: [
//             Expanded(child: ListViewBuilder(key: listViewState)),
//             // input bar nếu muốn thêm
//             //   ],
//             // ),
//
//             // 2. Icon floating bottom-right
//             Positioned(
//               bottom: 16,
//               right: 16,
//               child: Container(
//                 padding: EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                   borderRadius: BorderRadius.circular(24),
//                 ),
//                 child: GestureDetector(
//                   child: Icon(Icons.notification_add, color: Colors.white),
//                   onTap: () {
//                     listViewState.currentState?.addItem(
//                       "pos ${DateTime
//                           .now()
//                           .millisecondsSinceEpoch}",
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Defining a stateless widget named ListViewBuilder.

class CustomItem extends StatelessWidget {
  final String content;

  const CustomItem({Key? key, required this.content}) : super(key: key);

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
                Text(content),
                Text("Subtitle"),
                CachedNetworkImage(
                  imageUrl:
                  "https://cdn2.fptshop.com.vn/unsafe/Uploads/images/tin-tuc/172740/Originals/background-la-gi-1.jpg",
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Container(
                        height: 120,
                        color: Colors.grey[300], // placeholder tĩnh nhẹ
                      ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
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

class ListViewState extends State<ListViewBuilder> {
  final itemList = List.generate(1000, (index) => "asdf $index");
  final ScrollController _scrollController = ScrollController();

  void addItem(String content) {
    setState(() {
      print("addd r ne");
      itemList.insert(0, content);
    });
    _scrollController.animateTo(0, duration: Duration(milliseconds: 300),
        curve: Curves.easeOut);
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

          child: CustomItem(key: ValueKey("${itemList[index]}_$index"), content: itemList[index]),
        );
      },
    );
  }
}
