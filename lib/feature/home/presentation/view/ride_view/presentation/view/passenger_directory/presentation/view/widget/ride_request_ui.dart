import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/core/widget/custom_text_form_field.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/presentation/view/passenger_directory/presentation/view/widget/ride_option_tile.dart';

class RideRequestUI extends StatefulWidget {
  const RideRequestUI({super.key});

  @override
  State<RideRequestUI> createState() => _RideRequestUIState();
}

class _RideRequestUIState extends State<RideRequestUI> {
  int selectedRideOption = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 100.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RideOptionTile(
                  title: "موتسيكل",
                  price: "15 ج.م",
                  icon: FontAwesomeIcons.motorcycle,
                  isSelected: selectedRideOption == 0,
                  onTap: () {
                    setState(() {
                      selectedRideOption = 0;
                    });
                  },
                ),
                widthBox(10),
                RideOptionTile(
                  title: "ملاكي",
                  price: "20 ج.م",
                  icon: FontAwesomeIcons.car,
                  isSelected: selectedRideOption == 1,
                  onTap: () {
                    setState(() {
                      selectedRideOption = 1;
                    });
                  },
                ),
              ],
            ),
          ),
          heightBox(15),
          const CustomTextFormField(
            hintText: 'مكان الانطلاق',
            fillColor: AppColors.grey,
          ),
          heightBox(10),
          const CustomTextFormField(
            hintText: 'مكان الوصول',
            fillColor: AppColors.grey,
          ),
          heightBox(10),
          const Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "طريقة الدفع",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "*3334",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
          heightBox(10),
          CustomButton(
            buttonText: "طلب الركوب",
            onPressed: () {},
          ),
          heightBox(10),
        ],
      ),
    );
  }
}
