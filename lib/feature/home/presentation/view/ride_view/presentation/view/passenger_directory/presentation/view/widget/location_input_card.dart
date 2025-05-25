import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/presentation/view/passenger_directory/presentation/manager/cubit/passenger_directory_cubit.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/presentation/view/passenger_directory/presentation/view/widget/text_form.dart';

class LocationInputCard extends StatefulWidget {
  final String currentLocation;
  final TextEditingController destinationController;
  final Function(String) onSearchDestination;

  const LocationInputCard({
    super.key,
    required this.currentLocation,
    required this.destinationController,
    required this.onSearchDestination,
  });

  @override
  State<LocationInputCard> createState() => _LocationInputCardState();
}

class _LocationInputCardState extends State<LocationInputCard> {
  Timer? _debounce;
  FocusNode focusNode = FocusNode();
  bool _hasDestination = false;

  @override
  void initState() {
    super.initState();
    _hasDestination = widget.destinationController.text.isNotEmpty;
    widget.destinationController.addListener(_updateHasDestination);
    focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    focusNode.removeListener(_onFocusChange);
    focusNode.dispose();
    widget.destinationController.removeListener(_updateHasDestination);
    super.dispose();
  }

  void _updateHasDestination() {
    final newHasDestination = widget.destinationController.text.isNotEmpty;
    if (_hasDestination != newHasDestination) {
      setState(() {
        _hasDestination = newHasDestination;
      });
    }
  }

  void _onFocusChange() {
    if (focusNode.hasFocus && widget.destinationController.text.isNotEmpty) {
      widget.onSearchDestination(widget.destinationController.text);
    }
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    final currentValue = value;

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (widget.destinationController.text == currentValue) {
        if (currentValue.isNotEmpty) {
          widget.onSearchDestination(currentValue);
        } else {
          context.read<PassengerDirectoryCubit>().clearSearchSuggestions();
        }
      }
    });
  }

  void _clearDestination() {
    final wasFocused = focusNode.hasFocus;

    widget.destinationController.clear();

    final cubit = context.read<PassengerDirectoryCubit>();
    cubit.clearSearchSuggestions();
    cubit.resetDestination();

    if (wasFocused) {
      Future.delayed(Duration.zero, () => focusNode.requestFocus());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.getSurfaceColor(context),
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.my_location,
                color: AppColors.getPrimaryColor(context),
                size: 24.sp,
              ),
              widthBox(10),
              Expanded(
                child: Text(
                  widget.currentLocation,
                  style: Styles.font14GreyExtraBold(context),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.rtl,
                ),
              ),
            ],
          ),
          Divider(height: 20.h),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: AppColors.getPrimaryColor(context),
                size: 24.sp,
              ),
              widthBox(10),
              Expanded(
                child: CustomTextField(
                  fillColor: AppColors.getBackgroundColor(context),
                  controller: widget.destinationController,
                  focusNode: focusNode,
                  hintText: 'ابحث عن وجهتك',
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  onChanged: _onSearchChanged,
                ),
              ),
              if (_hasDestination)
                IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Colors.grey,
                    size: 20.sp,
                  ),
                  onPressed: _clearDestination,
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
