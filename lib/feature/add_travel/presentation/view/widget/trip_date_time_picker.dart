import 'package:custom_calender_picker/custom_calender_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/widget/custom_text_form_field.dart';
import 'package:travel_app/core/helper/spacing.dart';

class TripDateTimePicker extends StatefulWidget {
  const TripDateTimePicker({super.key});

  @override
  State<TripDateTimePicker> createState() => _TripDateTimePickerState();
}

class _TripDateTimePickerState extends State<TripDateTimePicker> {
  List<DateTime> selectedDates = [];

  String getFormattedDates() {
    if (selectedDates.isEmpty) return 'اختر تاريخ يوم الرحله';
    return selectedDates
        .map((e) => "${e.day}/${e.month}/${e.year}")
        .join(" , ");
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () async {
              var result = await showDialog(
                context: context,
                builder: (context) => Dialog(
                  insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CustomCalenderPicker(
                    initialDateList: selectedDates,
                    calenderThema: CalenderThema.white,
                    buttonText: "حفظ",
                    buttonColor: AppColors.primaryColor,
                    buttonTextColor: AppColors.white,
                  ),
                ),
              );
              if (result != null && result is List<DateTime>) {
                setState(() {
                  selectedDates = result;
                });
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 15.h,
                horizontal: 16.w,
              ),
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                getFormattedDates(),
                style: Styles.font14GreyExtraBold,
              ),
            ),
          ),
        ),
        widthBox(10),
        Expanded(
          child: CustomTextFormField(
            hintText: 'الوقت',
          ),
        ),
      ],
    );
  }
}
