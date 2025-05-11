import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/feature/home/presentation/view/passenger_view/view/widget/text_field_row.dart';

class TripForm extends StatelessWidget {
  const TripForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          const TextFieldRow(
            hintText: 'من : مكان الانطلاق',
          ),
          const TextFieldRow(
            icon: FontAwesomeIcons.locationPin,
            hintText: 'الى : مكان الوصول',
          ),
          const TextFieldRow(
            icon: FontAwesomeIcons.hashtag,
            hintText: 'العدد : عدد الأفراد',
            keyboardType: TextInputType.number,
          ),
          const TextFieldRow(
            icon: FontAwesomeIcons.dollar,
            hintText: 'السعر : سعر الفرد',
            keyboardType: TextInputType.number,
          ),
          heightBox(10),
          CustomButton(
            buttonText: 'تأكيد',
            onPressed: () {},
            backgroundColor: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
