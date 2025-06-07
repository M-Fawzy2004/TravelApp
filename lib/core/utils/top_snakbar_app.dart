import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

void showCustomTopSnackBar({
  required BuildContext context,
  String? label,
  required String message,
  VoidCallback? onPressed,
  Color? backgroundColor,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  final snackBar = SnackBar(
    content: Container(
      height: 60.h,
      alignment: Alignment.centerRight,
      child: Text(
        message,
        style: Styles.font16WhiteBold(context),
      ),
    ),
    action: label != null && label.isNotEmpty
        ? SnackBarAction(
            label: label,
            onPressed: onPressed ?? () {},
          )
        : null,
    backgroundColor: backgroundColor ?? AppColors.getPrimaryColor(context),
    duration: const Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(
      bottom: 85.h,
      left: 16.w,
      right: 16.w,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.r),
    ),
    padding: const EdgeInsets.symmetric(
      vertical: 0,
      horizontal: 16.0,
    ),
    elevation: 8,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showCustomTopOverlaySnackBar({
  required BuildContext context,
  required String message,
  Color? backgroundColor,
  Duration duration = const Duration(seconds: 3),
}) {
  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).padding.top + 10.h,
      left: 16.w,
      right: 16.w,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.getPrimaryColor(context),
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  message,
                  style: Styles.font16WhiteBold(context),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  Overlay.of(context).insert(overlayEntry);
  Future.delayed(duration, () {
    overlayEntry.remove();
  });
}
