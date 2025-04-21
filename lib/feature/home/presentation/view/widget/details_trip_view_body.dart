import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/utils/assets.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/core/widget/icon_back.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/home/presentation/view/widget/details_center_card.dart';
import 'package:travel_app/feature/home/presentation/view/widget/details_top_card.dart';
import 'package:travel_app/feature/home/presentation/view/widget/share_location_button.dart';

class DetailsTripViewBody extends StatelessWidget {
  const DetailsTripViewBody({
    super.key,
    required this.trip, required this.index,
  });
  final TripModel trip;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heightBox(10),
          const IconBack(),
          heightBox(20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(.2),
                  blurRadius: 6,
                  spreadRadius: 0,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Center(
              child: Text(
                'يسعدنا اهتمامك بالرحله',
                style: Styles.font18BlackBold,
              ),
            ),
          ),
          heightBox(20),
          DetailsTopCard(
            trip: trip,
            index: index,
          ),
          heightBox(20),
          DetailsCenterCard(trip: trip),
          heightBox(20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'موقع الخروج بالتفصيل',
                style: Styles.font16BlackBold,
              ),
              heightBox(10),
              Container(
                height: 150.h,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColors.primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(.2),
                      blurRadius: 6,
                      spreadRadius: 0,
                      offset: Offset(0, 1),
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage(Assets.imagesLoactionMap),
                    fit: BoxFit.fill,
                  ),
                ),
                child: ShareLocationButton(
                  title: 'معرفه موقع تحرك الرحله',
                ),
              ),
            ],
          ),
          heightBox(20),
          CustomButton(
            buttonText: 'احجز',
            textStyle: Styles.font16WhiteBold,
            onPressed: () {},
          ),
          heightBox(20),
          CustomButton(
            backgroundColor: AppColors.primaryColor,
            buttonText: 'تواصل مع صاحب الرحله',
            textStyle: Styles.font16WhiteBold,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
