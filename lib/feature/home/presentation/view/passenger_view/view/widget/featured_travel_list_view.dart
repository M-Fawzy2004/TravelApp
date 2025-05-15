import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/home/presentation/view/passenger_view/view/widget/featured_travel.dart';
import 'package:travel_app/feature/home/presentation/view/passenger_view/view/widget/view_all_featured.dart';

class FeaturedTravelListView extends StatelessWidget {
  const FeaturedTravelListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('الرحلات المميزة', style: Styles.font18BlackBold),
        heightBox(10),
        SizedBox(
          height: 130.h,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 7,
            separatorBuilder: (_, __) => widthBox(10),
            itemBuilder: (_, index) {
              if (index == 6) {
                return const ViewAllFeatured();
              } else {
                return const FeaturedTravel();
              }
            },
          ),
        ),
      ],
    );
  }
}
