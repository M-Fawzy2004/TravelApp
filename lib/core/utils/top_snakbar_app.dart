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
  final bool isDark = Theme.of(context).brightness == Brightness.dark;
  final snackBar = SnackBar(
    content: IntrinsicWidth(
      child: Container(
        constraints: BoxConstraints(
          minHeight: 60.h,
          maxWidth: MediaQuery.of(context).size.width * 0.85,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    Colors.white.withOpacity(0.3),
                    Colors.white.withOpacity(0.2),
                    Colors.white.withOpacity(0.1),
                  ]
                : [
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.5),
                  ],
            stops: const [0.0, 0.5, 1.0],
          ),
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.4)
                : Colors.black.withOpacity(0.2),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.15)
                  : Colors.black.withOpacity(0.25),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: isDark
                  ? Colors.white.withOpacity(0.15)
                  : Colors.white.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(-2, -2),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 12.h,
        ),
        child: Center(
          child: Text(
            message,
            style: Styles.font16WhiteBold(context).copyWith(
              color: AppColors.getBackgroundColor(context),
              fontWeight: FontWeight.w700,
              fontSize: 16.sp,
              shadows: [
                Shadow(
                  color: isDark
                      ? Colors.black.withOpacity(0.7)
                      : Colors.black.withOpacity(0.5),
                  offset: const Offset(0, 1),
                  blurRadius: 4,
                ),
              ],
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    ),
    action: label != null && label.isNotEmpty
        ? SnackBarAction(
            label: label,
            onPressed: onPressed ?? () {},
            textColor: AppColors.primaryColor,
          )
        : null,
    backgroundColor: Colors.transparent,
    duration: const Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(
      bottom: 85.h,
      left: 16.w,
      right: 16.w,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.r),
    ),
    padding: const EdgeInsets.all(0),
    elevation: 0,
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
  final bool isDark = Theme.of(context).brightness == Brightness.dark;
  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).padding.top + 20.h,
      left: 0,
      right: 0,
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: IntrinsicWidth(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              constraints: BoxConstraints(
                minHeight: 50.h,
                maxWidth: MediaQuery.of(context).size.width * 0.85,
                minWidth: 120.w,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [
                          Colors.white.withOpacity(0.3),
                          Colors.white.withOpacity(0.2),
                          Colors.white.withOpacity(0.1),
                        ]
                      : [
                          Colors.black.withOpacity(0.7),
                          Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.5),
                        ],
                  stops: const [0.0, 0.5, 1.0],
                ),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(0.4)
                      : Colors.black.withOpacity(0.2),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? Colors.black.withOpacity(0.2)
                        : Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                  BoxShadow(
                    color: isDark
                        ? Colors.white.withOpacity(0.15)
                        : Colors.white.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(-2, -2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                  child: Text(
                    message,
                    style: Styles.font16WhiteBold(context).copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: isDark
                              ? Colors.black.withOpacity(0.7)
                              : Colors.black.withOpacity(0.5),
                          offset: const Offset(0, 1),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
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
