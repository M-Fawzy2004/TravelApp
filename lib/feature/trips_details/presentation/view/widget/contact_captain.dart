import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/helper/extension.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/feature/message/presentation/view/chat_view.dart';

class ContactCaptian extends StatelessWidget {
  const ContactCaptian({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.navigateWithSlideTransition(const ChatView());
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 12.5.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.getBackgroundColor(context),
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Icon(
          FontAwesomeIcons.message,
          color: AppColors.getPrimaryColor(context),
        ),
      ),
    );
  }
}
