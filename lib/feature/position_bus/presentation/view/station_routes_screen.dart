import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/widget/icon_back.dart';
import 'package:travel_app/feature/position_bus/data/model/governorate_model.dart';
import 'package:travel_app/feature/position_bus/presentation/view/widget/route_list_tile.dart';

class StationRoutesScreen extends StatelessWidget {
  final Station station;

  const StationRoutesScreen({
    super.key,
    required this.station,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 140.h,
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.getPrimaryColor(context).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Stack(
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
                ),
              ),
              heightBox(20),
              Text(
                'المواصلات المتاحه فى الموقف:',
                style: Styles.font16BlackBold(context),
              ),
              heightBox(12),
              Expanded(
                child: station.routes.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 48.sp,
                              color: AppColors.primaryColor.withOpacity(0.5),
                            ),
                            heightBox(16),
                            Text(
                              'لا توجد مواقف متاحة',
                              style: Styles.font16BlackBold(context),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: station.routes.length,
                        separatorBuilder: (context, index) => heightBox(8),
                        itemBuilder: (context, index) {
                          final route = station.routes[index];
                          return RouteListTile(route: route);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
