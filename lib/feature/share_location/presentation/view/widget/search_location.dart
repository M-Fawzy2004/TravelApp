import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/feature/share_location/presentation/manager/location/location_cubit.dart';

class SearchLocation extends StatefulWidget {
  final TextEditingController? controller;
  final Function(String)? onSearchSubmitted;

  const SearchLocation({
    super.key,
    this.controller,
    this.onSearchSubmitted,
  });

  @override
  State<SearchLocation> createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  bool _isLoading = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationCubit, LocationState>(
      listener: (context, state) {
        // Update loading state based on LocationCubit state
        setState(() {
          _isLoading = state is LocationLoading;
        });

        // If location is loaded, unfocus the text field
        if (state is LocationLoaded && state.selectedLocation != null) {
          _focusNode.unfocus();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: TextField(
          controller: widget.controller,
          focusNode: _focusNode,
          textInputAction: TextInputAction.search,
          // Disable the field while loading
          enabled: !_isLoading,
          onSubmitted: (value) {
            if (value.isNotEmpty && widget.onSearchSubmitted != null) {
              widget.onSearchSubmitted!(value);
            }
          },
          decoration: InputDecoration(
            hintText: 'ابحث عن موقع...',
            prefixIcon: _isLoading
                ? SizedBox(
                    width: 18.sp,
                    height: 18.sp,
                    child: Center(
                      child: SizedBox(
                        width: 18.sp,
                        height: 18.sp,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  )
                : Icon(
                    FontAwesomeIcons.magnifyingGlass,
                    size: 18.sp,
                    color: AppColors.primaryColor,
                  ),
            suffixIcon:
                widget.controller != null && widget.controller!.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          FontAwesomeIcons.xmark,
                          size: 16.sp,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          widget.controller!.clear();
                          setState(() {});
                        },
                      )
                    : null,
            filled: true,
            fillColor: AppColors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide(
                  color: AppColors.primaryColor.withOpacity(0.3), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: const BorderSide(
                color: AppColors.primaryColor,
                width: 2,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide:
                  BorderSide(color: Colors.grey.withOpacity(0.3), width: 1),
            ),
          ),
        ),
      ),
    );
  }
}
