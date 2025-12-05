import 'package:flutter/material.dart';
import 'dart:async';

class ChatInput extends StatefulWidget {
  final void Function(String) onSend;
  final void Function(bool)? onTyping;

  const ChatInput({super.key, required this.onSend, this.onTyping});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final _ctrl = TextEditingController();
  Timer? _typingTimer;

  void _onTextChanged() {
    widget.onTyping?.call(true);
    _typingTimer?.cancel();
    _typingTimer = Timer(Duration(milliseconds: 800), () {
      widget.onTyping?.call(false);
    });
  }

  @override
  void initState() {
    super.initState();
    _ctrl.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _ctrl.removeListener(_onTextChanged);
    _ctrl.dispose();
    _typingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          color: Colors.white,
          child: Row(
            children: [
              IconButton(icon: Icon(Icons.add), onPressed: () {}),
              Expanded(
                child: TextField(
                  controller: _ctrl,
                  minLines: 1,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Type a message',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  final t = _ctrl.text.trim();
                  if (t.isEmpty) return;
                  widget.onSend(t);
                  _ctrl.clear();
                  widget.onTyping?.call(false);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
