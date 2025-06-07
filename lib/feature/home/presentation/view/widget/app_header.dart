import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/helper/get_user.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/utils/assets.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final getUserName = getUser()?.firstName;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(Assets.imagesRihlaLogo, height: 60.h),
        const Spacer(),
        Text(
          'أهلا بك $getUserName',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Styles.font16BlackBold(context),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: Icon(
            FontAwesomeIcons.solidBell,
            size: 22.sp,
            color: AppColors.getPrimaryColor(context),
          ),
        ),
      ],
    );
  }
}
