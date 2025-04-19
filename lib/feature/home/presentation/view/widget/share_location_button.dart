import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class ShareLocationButton extends StatelessWidget {
  const ShareLocationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: Align(
        alignment: Alignment.bottomRight,
        child: ElevatedButton.icon(
          onPressed: () {
            // context.push(AppRouter.mapView);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            minimumSize: Size(10.w, 10.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            elevation: 10,
          ),
          icon: Icon(
            FontAwesomeIcons.locationArrow,
            color: AppColors.black,
            size: 18.sp,
          ),
          label: Text(
            'شارك موقعك',
            style: Styles.font16WhiteBold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
