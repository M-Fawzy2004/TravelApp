import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/helper/extension.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/message/presentation/view/widget/chat_view_body.dart';
import 'package:travel_app/feature/message/presentation/view/widget/user_avatar.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 2,
        scrolledUnderElevation: 0,
        title: Text(
          'Mohamed Fawzy',
          style: Styles.font20ExtraBlackBold,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(FontAwesomeIcons.arrowRight),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: UserAvatar(
              radius: 20.r,
            ),
          ),
        ],
      ),
      body: const ChatViewBody(),
    );
  }
}
