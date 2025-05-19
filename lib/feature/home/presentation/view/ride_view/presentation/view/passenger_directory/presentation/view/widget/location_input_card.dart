import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/widget/custom_text_form_field.dart';

class LocationInputCard extends StatelessWidget {
  const LocationInputCard({
    super.key,
    required this.currentLocation,
    required this.destinationController,
  });

  final String currentLocation;
  final TextEditingController destinationController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                children: [
                  const Icon(
                    Icons.circle,
                    color: AppColors.primaryColor,
                  ),
                  Container(
                    width: 3.w,
                    height: 40.h,
                    color: AppColors.darkGrey,
                  ),
                  const Icon(
                    Icons.circle_outlined,
                    color: AppColors.lightGrey,
                  ),
                ],
              ),
              widthBox(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentLocation,
                      style: Styles.font16BlackBold.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    heightBox(20),
                    CustomTextFormField(
                      hintText: 'أدخل وجهتك',
                      fillColor: AppColors.grey,
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          FontAwesomeIcons.search,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
