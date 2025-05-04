// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class TripDateTimePicker extends StatelessWidget {
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final Function(DateTime) onDateChanged;
  final Function(TimeOfDay) onTimeChanged;
  final String? dateErrorText;
  final String? timeErrorText;

  const TripDateTimePicker({
    super.key,
    this.selectedDate,
    this.selectedTime,
    required this.onDateChanged,
    required this.onTimeChanged,
    this.dateErrorText,
    this.timeErrorText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: AppColors.primaryColor,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null) {
                    onDateChanged(picked);
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 15.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedDate != null
                            ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                            : 'اختر التاريخ',
                        style: selectedDate != null
                            ? Styles.font14DarkGreyExtraBold
                            : Styles.font14DarkGreyBold,
                      ),
                      const Icon(
                        Icons.calendar_today,
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
              if (dateErrorText != null)
                Padding(
                  padding: EdgeInsets.only(top: 5.h, right: 10.w),
                  child: Text(
                    dateErrorText!,
                    style: TextStyle(color: Colors.red, fontSize: 12.sp),
                  ),
                ),
            ],
          ),
        ),
        widthBox(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: selectedTime ?? TimeOfDay.now(),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: AppColors.primaryColor,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null) {
                    onTimeChanged(picked);
                  }
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedTime != null
                            ? '${selectedTime!.hour}:${selectedTime!.minute.toString().padLeft(2, '0')}'
                            : 'اختر الوقت',
                        style: selectedTime != null
                            ? Styles.font14DarkGreyExtraBold
                            : Styles.font14GreyExtraBold,
                      ),
                      const Icon(
                        Icons.access_time,
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
              if (timeErrorText != null)
                Padding(
                  padding: EdgeInsets.only(top: 5.h, right: 10.w),
                  child: Text(
                    timeErrorText!,
                    style: TextStyle(color: Colors.red, fontSize: 12.sp),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
