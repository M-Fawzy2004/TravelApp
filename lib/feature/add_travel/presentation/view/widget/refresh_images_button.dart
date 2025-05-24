import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RefreshImagesButton extends StatelessWidget {
  final bool isSearching;
  final VoidCallback onPressed;

  const RefreshImagesButton({
    super.key,
    required this.isSearching,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: isSearching ? null : onPressed,
        icon: Icon(
          Icons.refresh,
          size: 16.sp,
        ),
        label: Text(
          'صور جديدة',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
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
