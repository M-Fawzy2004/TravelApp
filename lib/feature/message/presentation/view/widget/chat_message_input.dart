import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/feature/message/presentation/view/widget/message_input_container.dart';

class ChatMessageInput extends StatefulWidget {
  const ChatMessageInput({super.key});

  @override
  State<ChatMessageInput> createState() => _ChatMessageInputState();
}

class _ChatMessageInputState extends State<ChatMessageInput> {
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _messageController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(
                minWidth: 40.w,
                minHeight: 40.h,
              ),
              icon: Icon(
                FontAwesomeIcons.paperPlane,
                color: Colors.white,
                size: 16.sp,
              ),
              onPressed: () {
                if (_messageController.text.trim().isNotEmpty) {
                  _messageController.clear();
                  _focusNode.requestFocus();
                }
              },
            ),
          ),
          widthBox(8),
          const Expanded(
            child: MessageInputContainer(),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              FontAwesomeIcons.microphone,
              color: AppColors.primaryColor,
              size: 22.sp,
            ),
          ),
        ],
      ),
    );
  }
}
