import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/position_bus/data/model/governorate_model.dart';

class AviliablePoistion extends StatelessWidget {
  const AviliablePoistion({
    super.key,
    required this.station,
  });

  final Station station;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.location_on,
          size: 16.w,
          color: AppColors.primaryColor,
        ),
        widthBox(10),
        Expanded(
          child: Text(
            station.name,
            style: Styles.font12GreyExtraBold(context),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
