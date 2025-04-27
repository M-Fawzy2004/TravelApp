import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/feature/message/presentation/view/widget/user_avatar.dart';

class UsersScrollRow extends StatelessWidget {
  const UsersScrollRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(
          10,
          (index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: const UserAvatar(),
          ),
        ),
      ),
    );
  }
}
