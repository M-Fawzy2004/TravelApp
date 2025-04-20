import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_form_cubit/trip_form_cubit.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/row_with_label.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/trip_date_time_picker.dart';

class DateTimePicker extends StatelessWidget {
  const DateTimePicker({
    super.key,
    this.selectedDate,
    this.selectedTime,
    this.dateErrorText,
    this.timeErrorText,
  });

  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;

  final String? dateErrorText;
  final String? timeErrorText;

  @override
  Widget build(BuildContext context) {
    return RowWithLabel(
      label: 'تاريخ الرحلة',
      widget: TripDateTimePicker(
        selectedDate: selectedDate,
        selectedTime: selectedTime,
        onDateChanged: (date) {
          context.read<TripFormCubit>().setTripDate(date);
        },
        onTimeChanged: (time) {
          context.read<TripFormCubit>().setTripTime(time);
        },
        dateErrorText: dateErrorText,
        timeErrorText: timeErrorText,
      ),
    );
  }
}
