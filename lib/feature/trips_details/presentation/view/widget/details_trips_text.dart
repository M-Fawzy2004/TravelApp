import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/trips_details/presentation/view/widget/details_trip_view_body.dart';

class DetailsTripsText extends StatefulWidget {
  const DetailsTripsText({
    super.key,
    required this.widget,
  });

  final DetailsTripViewBody widget;

  @override
  State<DetailsTripsText> createState() => _DetailsTripsTextState();
}

class _DetailsTripsTextState extends State<DetailsTripsText>
    with TickerProviderStateMixin {
  bool _isExpanded = false;
  bool _showReadMore = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Check if text needs "Read More" after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkIfTextOverflows();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _checkIfTextOverflows() {
    final textPainter = TextPainter(
      text: TextSpan(
        text: widget.widget.trip.additionalDetails,
        style: Styles.font16BlackBold(context).copyWith(
          color: Colors.grey.shade700,
        ),
      ),
      maxLines: 5,
      textDirection: TextDirection.rtl,
    );

    textPainter.layout(maxWidth: MediaQuery.of(context).size.width - 40.w);

    if (textPainter.didExceedMaxLines) {
      setState(() {
        _showReadMore = true;
      });
    }
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });

    if (_isExpanded) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.getBackgroundColor(context).withOpacity(0.2),
              borderRadius: BorderRadius.circular(25.r),
              border: Border.all(
                color: AppColors.getSurfaceColor(context),
                width: 1.5,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.deepOrange.withOpacity(0.3),
                          Colors.orange.withOpacity(0.3),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.4),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            Icons.description,
                            color: Colors.deepOrange,
                            size: 16.sp,
                          ),
                        ),
                        widthBox(10),
                        Text(
                          'تفاصيل إضافية',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.getTextColor(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  heightBox(15),
                  AnimatedCrossFade(
                    firstChild: Text(
                      widget.widget.trip.additionalDetails,
                      style: Styles.font16BlackBold(context).copyWith(
                        color: Colors.grey.shade700,
                        height: 1.5,
                      ),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                    secondChild: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Text(
                        widget.widget.trip.additionalDetails,
                        style: Styles.font16BlackBold(context).copyWith(
                          color: Colors.grey.shade700,
                          height: 1.5,
                        ),
                      ),
                    ),
                    crossFadeState: _isExpanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 300),
                  ),
                  if (_showReadMore) ...[
                    SizedBox(height: 12.h),
                    Center(
                      child: GestureDetector(
                        onTap: _toggleExpanded,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.darkPrimaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.5),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _isExpanded ? 'عرض أقل' : 'عرض المزيد',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue.shade700,
                                ),
                              ),
                              widthBox(5),
                              AnimatedRotation(
                                turns: _isExpanded ? 0.5 : 0.0,
                                duration: const Duration(milliseconds: 300),
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.blue.shade700,
                                  size: 18.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
