import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/extension.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/message/presentation/view/chat_view.dart';
import 'package:travel_app/feature/message/presentation/view/widget/user_avatar.dart';

class UserMessageCard extends StatelessWidget {
  const UserMessageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.navigateWithSlideTransition(const ChatView());
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.r),
          ),
          color: AppColors.getSurfaceColor(context),
          child: ListTile(
            title: Text(
              'Mohamed Fawzy',
              style: Styles.font14DarkGreyBold(context),
            ),
            subtitle: Text(
              'اهلا بك في التطبيق',
              style: Styles.font12GreyExtraBold(context),
            ),
            leading: const UserAvatar(),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '2:30 PM',
                  style: Styles.font14DarkGreyBold(context),
                ),
                widthBox(10),
                Container(
                  height: 15.h,
                  width: 15.w,
                  decoration: BoxDecoration(
                    color: AppColors.getPrimaryColor(context),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
