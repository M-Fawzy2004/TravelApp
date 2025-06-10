import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/core/helper/app_router.dart';
import 'package:travel_app/core/helper/get_user.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final getUserName = getUser()?.firstName;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            context.push(AppRouter.tripBooking);
          },
          icon: Icon(
            FontAwesomeIcons.calendar,
            color: AppColors.getPrimaryColor(context),
          ),
        ),
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
            color: AppColors.getPrimaryColor(context),
          ),
        ),
      ],
    );
  }
}
