import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class CustomCalendarDate extends StatefulWidget {
  final Function(List<DateTime?>) onDateChanged;

  const CustomCalendarDate({super.key, required this.onDateChanged});

  @override
  State<CustomCalendarDate> createState() => _CustomCalendarDateState();
}

class _CustomCalendarDateState extends State<CustomCalendarDate> {
  List<DateTime?> _dates = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (_) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: CalendarDatePicker2(
                config: CalendarDatePicker2Config(
                  calendarType: CalendarDatePicker2Type.range,
                ),
                value: _dates,
                onValueChanged: (dates) {
                  setState(() {
                    _dates = dates;
                  });
                  widget.onDateChanged(_dates);
                },
              ),
            );
          },
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: Text(
            'اضغط لإضافه التاريخ',
            style: Styles.font16BlackBold,
          ),
        ),
      ),
    );
  }
}
