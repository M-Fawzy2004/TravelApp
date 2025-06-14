import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_cubit/trip_cubit.dart';
import 'dart:async';

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
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h, // ارتفاع ثابت لتجنب مشاكل الـ layout
      margin: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 16.w, // إضافة margin أفقي
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(
          color: AppColors.getLightGreyColor(context).withOpacity(0.2),
          width: 1.0,
        ),
        // إضافة shadow خفيف
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        focusNode: _focusNode,
        style: Styles.font14BlackBold(context),
        textAlignVertical: TextAlignVertical.center,
        onChanged: (value) {
          _debouncedSearch(value);
        },
        onSubmitted: (value) {
          _performSearch(value);
          _focusNode.unfocus();
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 16.w,
          ),
          fillColor: AppColors.getSurfaceColor(context),
          filled: true,
          hintText: widget.hintText ?? "ابحث...",
          hintStyle: Styles.font14GreyExtraBold(context),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.r),
            borderSide: BorderSide.none,
          ),
          suffixIcon: _buildSuffixIcon(),
          prefixIcon: _buildPrefixIcon(),
        ),
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    return GestureDetector(
      onTap: () {
        if (_searchController.text.isNotEmpty) {
          _performSearch(_searchController.text);
          _focusNode.unfocus();
        }
      },
      child: Container(
        padding: EdgeInsets.all(14.w),
        child: FaIcon(
          FontAwesomeIcons.magnifyingGlass,
          size: 18.sp,
          color: AppColors.getLightGreyColor(context),
        ),
      ),
    );
  }

  Widget? _buildPrefixIcon() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: _searchController.text.isNotEmpty
          ? IconButton(
              key: const ValueKey('clear_button'),
              icon: Icon(
                Icons.clear,
                size: 20.sp,
                color: AppColors.getLightGreyColor(context),
              ),
              onPressed: () {
                _clearSearch();
              },
            )
          : SizedBox(
              key: const ValueKey('empty_space'),
              width: 48.w,
            ),
    );
  }

  void _debouncedSearch(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _performSearch(query);
    });
  }

  void _performSearch(String query) {
    try {
      if (query.trim().isEmpty) {
        context.read<TripCubit>().getAllTrips();
      } else {
        context.read<TripCubit>().searchTrips(query.trim());
      }
    } catch (e) {
      debugPrint('Search error: $e');
    }
  }

  void _clearSearch() {
    _searchController.clear();
    _debounceTimer?.cancel();
    context.read<TripCubit>().getAllTrips();
    if (mounted) {
      setState(() {});
    }
  }
}
