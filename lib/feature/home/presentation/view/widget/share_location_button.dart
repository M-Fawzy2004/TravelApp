import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/helper/extension.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/share_location/presentation/view/share_location_view_multi_provider.dart';

class ShareLocationButton extends StatelessWidget {
  const ShareLocationButton({
    super.key,
    required this.title,
    this.onLocationUpdated,
  });

  final String title;
  final VoidCallback? onLocationUpdated;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: Align(
        alignment: Alignment.bottomRight,
        child: ElevatedButton.icon(
          onPressed: () {
            context.navigateWithSlideTransition(
              const ShareLocationViewMultiProvider(),
            );
            if (onLocationUpdated != null) {
              onLocationUpdated!();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.getPrimaryColor(context),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            minimumSize: Size(10.w, 10.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            elevation: 10,
          ),
          icon: Icon(
            FontAwesomeIcons.locationPin,
            color: AppColors.whitewithOpacity,
            size: 18.sp,
          ),
          label: Text(
            title,
            style: Styles.font16WhiteBold(context),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
