// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_form_cubit/trip_form_cubit.dart';

class DestinationField extends StatefulWidget {
  final String? errorText;
  final String? initialValue;

  const DestinationField({
    super.key,
    this.errorText,
    this.initialValue,
  });

  @override
  State<DestinationField> createState() => _DestinationFieldState();
}

class _DestinationFieldState extends State<DestinationField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);

    if (widget.initialValue != null && widget.initialValue!.isNotEmpty) {
      Future.microtask(
        () {
          context
              .read<TripFormCubit>()
              .setDestinationName(widget.initialValue!);
        },
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الوجهة',
          style: Styles.font16BlackBold,
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Colors.white,
            border: Border.all(
              color:
                  widget.errorText != null ? Colors.red : Colors.grey.shade300,
            ),
          ),
          child: TextFormField(
            controller: _controller,
            onChanged: (value) {
              context.read<TripFormCubit>().setDestinationName(value);
            },
            decoration: InputDecoration(
              hintText: 'المكان الذي تقصده (مثال: الرياض ، مكة)',
              hintStyle: Styles.font14DarkGreyBold,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
              border: InputBorder.none,
            ),
          ),
        ),
        if (widget.errorText != null)
          Padding(
            padding: EdgeInsets.only(top: 8.h, right: 12.w),
            child: Text(
              widget.errorText!,
              style: TextStyle(color: Colors.red, fontSize: 12.sp),
            ),
          ),
      ],
    );
  }
}
