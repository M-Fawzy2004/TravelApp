import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';

class SearchImageButton extends StatefulWidget {
  final bool isSearching;
  final VoidCallback onPressed;

  const SearchImageButton({
    super.key,
    required this.isSearching,
    required this.onPressed,
  });

  @override
  State<SearchImageButton> createState() => _SearchImageButtonState();
}

class _SearchImageButtonState extends State<SearchImageButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: ElevatedButton.icon(
        onPressed: widget.isSearching ? null : widget.onPressed,
        icon: widget.isSearching
            ? SizedBox(
                width: 16.w,
                height: 16.h,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Icon(
                Icons.search,
                size: 18.sp,
              ),
        label: Text(
          widget.isSearching ? 'جاري البحث...' : 'بحث عن الصور',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.getPrimaryColor(context),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
    );
  }
}
