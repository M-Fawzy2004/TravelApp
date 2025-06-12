import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageInputTextField extends StatelessWidget {
  const MessageInputTextField({
    super.key,
    required TextEditingController messageController,
    required FocusNode focusNode,
  })  : _messageController = messageController,
        _focusNode = focusNode;

  final TextEditingController _messageController;
  final FocusNode _focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: TextField(
        controller: _messageController,
        focusNode: _focusNode,
        maxLines: null,
        minLines: 1,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: 'اكتب رسالتك هنا',
          hintTextDirection: TextDirection.rtl,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
        ),
      ),
    );
  }
}
