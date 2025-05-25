import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class CaptainAvailabilityTile extends StatefulWidget {
  const CaptainAvailabilityTile({super.key});

  @override
  State<CaptainAvailabilityTile> createState() =>
      _CaptainAvailabilityTileState();
}

class _CaptainAvailabilityTileState extends State<CaptainAvailabilityTile> {
  bool _isAvailable = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        color: AppColors.getSurfaceColor(context),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FontAwesomeIcons.circleDot,
            color: _isAvailable ? Colors.green : Colors.red,
            size: 20.sp,
          ),
          Text(
            ' ${_isAvailable ? "متاح" : "غير متاح"}',
            style: Styles.font16BlackBold(context),
          ),
          widthBox(35),
          Switch(
            value: _isAvailable,
            activeColor: AppColors.getPrimaryColor(context),
            activeTrackColor: AppColors.getPrimaryColor(context).withOpacity(0.2),
            inactiveTrackColor: AppColors.getSurfaceColor(context),
            inactiveThumbColor: AppColors.getPrimaryColor(context),
            onChanged: (val) {
              setState(() {
                _isAvailable = val;
              });
            },
          ),
        ],
      ),
    );
  }
}
