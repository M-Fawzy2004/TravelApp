import 'package:flutter/material.dart';
import 'package:travel_app/feature/message/presentation/view/widget/chat_message_input.dart';
import 'package:travel_app/feature/message/presentation/view/widget/conversation_list.dart';

class ChatViewBody extends StatefulWidget {
  const ChatViewBody({super.key});

  @override
  State<ChatViewBody> createState() => _ChatViewBodyState();
}

class _ChatViewBodyState extends State<ChatViewBody> {
  Duration duration = const Duration();
  Duration position = const Duration();
  bool isPlaying = false;
  bool isLoading = false;
  bool isPause = false;

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          child: ConversationList(),
        ),
        ChatMessageInput(),
      ],
    );
  }
}
