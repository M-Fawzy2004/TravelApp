import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/widget/icon_back.dart';
import 'package:travel_app/feature/position_bus/data/model/governorate_model.dart';

class StationHeader extends StatelessWidget {
  const StationHeader({
    super.key,
    required this.station,
  });

  final Station station;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const IconBack(),
        Positioned.fill(
          child: Column(
            children: [
              Icon(
                Icons.location_on,
                size: 40.sp,
                color: AppColors.primaryColor,
              ),
              heightBox(8),
              Text(
                station.name,
                style: Styles.font18BlackBold(context),
                textAlign: TextAlign.center,
              ),
              heightBox(4),
              Text(
                'عدد المواصلات: ${station.routes.length}',
                style: Styles.font14GreyExtraBold(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
