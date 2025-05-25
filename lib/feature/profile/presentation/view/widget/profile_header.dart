import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/get_user.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/auth/domain/entity/user_entity.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final firstName = getUser()!.firstName ?? '';
    final lastName = getUser()!.lastName ?? '';
    final role = getUser()!.role ?? '';

    String userRoleText = (role == UserRole.passenger)
        ? 'راكب'
        : (role == UserRole.directDelivery)
            ? 'كابتن توصيل مباشر'
            : 'كابتن رحلات';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35.r,
            backgroundColor: AppColors.getLightGreyColor(context),
            child: Icon(Icons.person,
                color: AppColors.getSurfaceColor(context), size: 35.h),
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$firstName $lastName',
                style: Styles.font30ExtraBlackBold(context),
              ),
              Text(
                'نوع المستخدم: $userRoleText',
                style: Styles.font14GreyExtraBold(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
