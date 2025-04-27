import 'package:flutter/material.dart';
import 'package:travel_app/feature/message/presentation/view/widget/message_view_body.dart';

class MessageView extends StatelessWidget {
  const MessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: MessageViewBody(),
      ),
    );
  }
}
