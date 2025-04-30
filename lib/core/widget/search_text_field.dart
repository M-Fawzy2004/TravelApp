// Updated SearchTextField with search functionality

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_cubit/trip_cubit.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    super.key,
    this.hintText,
  });

  final String? hintText;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(.2),
            blurRadius: 5,
            spreadRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        focusNode: _focusNode,
        style: Styles.font16BlackBold,
        onChanged: (value) {
          _performSearch(value);
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 15.h,
            horizontal: 16.w,
          ),
          fillColor: AppColors.white,
          filled: true,
          hintText: widget.hintText,
          hintStyle: Styles.font14DarkGreyExtraBold.copyWith(
            fontWeight: FontWeight.w900,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: BorderSide.none,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              if (_searchController.text.isNotEmpty) {
                _performSearch(_searchController.text);
                _focusNode.unfocus();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: FaIcon(
                FontAwesomeIcons.search,
                size: 20.sp,
              ),
            ),
          ),
          // Add clear button when text is entered
          suffixIconConstraints: const BoxConstraints(minWidth: 60),
          prefixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    // Reset to show all trips when search is cleared
                    context.read<TripCubit>().getAllTrips();
                  },
                )
              : null,
        ),
      ),
    );
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      // If search query is empty, show all trips
      context.read<TripCubit>().getAllTrips();
    } else {
      // Search trips by query
      context.read<TripCubit>().searchTrips(query);
    }
  }
}
