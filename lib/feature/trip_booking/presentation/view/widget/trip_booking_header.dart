import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class TripBookingHeader extends StatefulWidget {
  final Function(bool isFavoriteMode) onFavoriteToggle;
  final bool initialFavoriteMode;

  const TripBookingHeader({
    super.key,
    required this.onFavoriteToggle,
    this.initialFavoriteMode = false,
  });

  @override
  State<TripBookingHeader> createState() => _TripBookingHeaderState();
}

class _TripBookingHeaderState extends State<TripBookingHeader> {
  late bool _isFavoriteMode;

  @override
  void initState() {
    super.initState();
    _isFavoriteMode = widget.initialFavoriteMode;
  }

  @override
  void didUpdateWidget(TripBookingHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialFavoriteMode != oldWidget.initialFavoriteMode) {
      _isFavoriteMode = widget.initialFavoriteMode;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.getPrimaryColor(context).withOpacity(0.08),
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: Center(
              child: Text(
                _isFavoriteMode
                    ? 'رحلاتك المفضلة'
                    : 'مرحبًا بك! استعرض تذاكرك واحجز رحلتك الآن ✈️',
                style: Styles.font16BlackBold(context),
              ),
            ),
          ),
        ),
        widthBox(10),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              final newState = !_isFavoriteMode;
              setState(() => _isFavoriteMode = newState);
              widget.onFavoriteToggle(newState);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              decoration: BoxDecoration(
                color: _isFavoriteMode
                    ? AppColors.getPrimaryColor(context).withOpacity(0.3)
                    : AppColors.getPrimaryColor(context).withOpacity(0.1),
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: Center(
                child: Icon(
                  _isFavoriteMode
                      ? FontAwesomeIcons.solidHeart
                      : FontAwesomeIcons.heart,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
