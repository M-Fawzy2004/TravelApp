import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/core/helper/app_router.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class CustomAddTravel extends StatelessWidget {
  const CustomAddTravel({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      mini: true,
      backgroundColor: AppColors.getPrimaryColor(context),
      onPressed: () {
        showCupertinoModalPopup(
          context: context,
          builder: (context) => CupertinoActionSheet(
            title: Text(
              'إضافة رحلة',
              style: Styles.font18BlackBold(context).copyWith(
                fontFamily: 'font',
              ),
            ),
            message: Text(
              'هل تريد إضافة وجهتك القادمة أو عرض توصيلك؟',
              style: Styles.font16BlackBold(context).copyWith(
                color: AppColors.getLightGreyColor(context),
                fontFamily: 'font',
              ),
              textAlign: TextAlign.center,
            ),
            actions: [
              CupertinoActionSheetAction(
                onPressed: () {
                  context.pop();
                  context.push(AppRouter.addTravel);
                },
                child: Text(
                  'أضف رحلتك الآن',
                  style: Styles.font16BlackBold(context).copyWith(
                    color: AppColors.getPrimaryColor(context),
                    fontFamily: 'font',
                  ),
                ),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () => Navigator.of(context).pop(),
              isDefaultAction: true,
              child: Text(
                'إلغاء',
                style: Styles.font16BlackBold(context).copyWith(
                  color: Colors.red,
                  fontFamily: 'font',
                ),
              ),
            ),
          ),
        );
      },
      child: FaIcon(
        FontAwesomeIcons.plus,
        size: 15.sp,
        color: AppColors.getSurfaceColor(context),
      ),
    );
  }
}
