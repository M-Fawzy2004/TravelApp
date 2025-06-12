import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/extension.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/position_bus/presentation/view/station_routes_screen.dart';
import 'package:travel_app/feature/position_bus/presentation/view/widget/aviliable_poistion.dart';
import 'package:travel_app/feature/position_bus/presentation/view/widget/governorate_card.dart';

class ExpandableStationsList extends StatelessWidget {
  const ExpandableStationsList({
    super.key,
    required this.isExpanded,
    required this.widget,
  });

  final bool isExpanded;
  final GovernorateCard widget;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: isExpanded
          ? Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.getSurfaceColor(context).withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.r),
                  bottomRight: Radius.circular(25.r),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'المواقف المتاحة:',
                    style: Styles.font14GreyExtraBold(context),
                  ),
                  heightBox(10),
                  ...widget.stations.map(
                    (station) => InkWell(
                      onTap: () {
                        context.navigateWithSlideTransition(
                          StationRoutesScreen(
                            station: station,
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 5.h),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 14.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.getSurfaceColor(context),
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: AviliablePoistion(
                          station: station,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
