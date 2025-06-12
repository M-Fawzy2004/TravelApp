import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/widget/custom_text_form_field.dart';
import 'package:travel_app/feature/position_bus/data/model/governorate_model.dart';
import 'package:travel_app/feature/position_bus/presentation/view/widget/empty_state_widget.dart';
import 'package:travel_app/feature/position_bus/presentation/view/widget/station_feedback_form.dart';
import 'package:travel_app/feature/position_bus/presentation/view/widget/station_header.dart';
import 'package:travel_app/feature/position_bus/presentation/view/widget/station_routes_list.dart';

class StationRoutesScreenBody extends StatelessWidget {
  const StationRoutesScreenBody({
    super.key,
    required this.station,
  });

  final Station station;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
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
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: StationHeader(station: station),
          ),
          heightBox(10),
          Text(
            'عاوز تروح فين من ${station.name} واحنا ندلك علي اقرب خط فى حال عدم وحود موقف للمكان اللى انت رايحه',
            style: Styles.font14GreyExtraBold(context),
          ),
          heightBox(10),
          const CustomTextFormField(
            hintText: 'ابحث عن المكان اللى تريده',
          ),
          heightBox(20),
          Text(
            'المواصلات المتاحه فى الموقف:',
            style: Styles.font16BlackBold(context),
          ),
          heightBox(12),
          station.routes.isEmpty
              ? const EmptyStateWidget()
              : StationRoutesList(station: station),
          heightBox(16),
          StationFeedbackForm(station: station),
        ],
      ),
    );
  }
}
