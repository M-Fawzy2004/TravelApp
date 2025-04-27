import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/message/presentation/view/widget/user_avatar.dart';

class UserMessageCard extends StatelessWidget {
  const UserMessageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Card(
        color: AppColors.grey,
        child: ListTile(
          title: Text(
            'Mohamed Fawzy',
            style: Styles.font14DarkGreyBold,
          ),
          subtitle: Text(
            'اهلا بك في التطبيق',
            style: Styles.font12GreyExtraBold,
          ),
          leading: const UserAvatar(),
          trailing: Text(
            '2:30 PM',
            style: Styles.font14DarkGreyBold,
          ),
        ),
      ),
    );
  }
}
