import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/trip_booking/presentation/manager/booking_cubit/booking_cubit.dart';

class ActionSliderButton extends StatefulWidget {
  const ActionSliderButton({super.key});

  @override
  State<ActionSliderButton> createState() => _ActionSliderButtonState();
}

class _ActionSliderButtonState extends State<ActionSliderButton>
    with SingleTickerProviderStateMixin {
  double _dragPosition = 0;
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  bool _isCompleted = false;
  final double _buttonWidth = 50;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onPanUpdate(DragUpdateDetails details, double maxSlide) {
    setState(() {
      _dragPosition += details.delta.dx;
      if (_dragPosition < 0) _dragPosition = 0;
      if (_dragPosition > maxSlide) _dragPosition = maxSlide;
    });
  }

  void _onPanEnd(DragEndDetails details, double maxSlide) {
    if (_dragPosition > maxSlide * 0.8) {
      setState(() {
        _dragPosition = maxSlide;
        _isCompleted = true;
      });
      _animationController.forward();
      _showBookingConfirmationDialog(context);
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          _resetSlider();
        }
      });
    } else {
      _resetSlider();
    }
  }

  void _resetSlider() {
    setState(() {
      _dragPosition = 0;
      _isCompleted = false;
    });
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    bool hasBookings = true;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: AppColors.getSurfaceColor(context),
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          if (hasBookings) ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'عدد الحجوزات: ${context.watch<BookingCubit>().bookingEntity.bookingItems.length}',
                  style: Styles.font14GreyExtraBold(context),
                ),
                Text(
                  'السعر: ${context.watch<BookingCubit>().bookingEntity.calculateTotalPrice()} ج.م',
                  style: Styles.font14GreyExtraBold(context),
                ),
                Text(
                  'الضريبة: ${context.watch<BookingCubit>().bookingEntity.calculateTax()} ج.م',
                  style: Styles.font14GreyExtraBold(context),
                ),
                heightBox(10),
                Container(
                  color: AppColors.darkPrimaryColor,
                  width: double.infinity,
                  height: 1.h,
                ),
                heightBox(10),
                Text(
                  'المجموع الكلي: ${context.watch<BookingCubit>().bookingEntity.calculateGrandTotal()} ج.م',
                  style: Styles.font16BlackBold(context),
                ),
              ],
            ),
          ],
          heightBox(20),
          // ignore: dead_code
          hasBookings ? _buildSliderButton(context) : const SizedBox(),
        ],
      ),
    );
  }

  Widget _buildSliderButton(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxSlide = constraints.maxWidth - _buttonWidth - 8;

        return Container(
          height: 60.h,
          decoration: BoxDecoration(
            color: AppColors.getPrimaryColor(context).withOpacity(0.1),
            borderRadius: BorderRadius.circular(30.r),
            border: Border.all(
              color: AppColors.getPrimaryColor(context).withOpacity(0.3),
              width: 2,
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: AnimatedBuilder(
                  animation: _slideAnimation,
                  builder: (context, child) {
                    return Container(
                      width: _dragPosition + _buttonWidth + 4,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.getPrimaryColor(context).withOpacity(0.4),
                            AppColors.getPrimaryColor(context).withOpacity(0.2),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    );
                  },
                ),
              ),
              Center(
                child: AnimatedOpacity(
                  opacity: _isCompleted ? 0.3 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    _isCompleted ? 'تم التأكيد' : 'اسحب لتأكيد الحجز',
                    style: TextStyle(
                      color: AppColors.getPrimaryColor(context),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: _isCompleted
                    ? const Duration(milliseconds: 300)
                    : Duration.zero,
                left: _dragPosition + 4,
                top: 2.h,
                child: GestureDetector(
                  onPanUpdate: _isCompleted
                      ? null
                      : (details) => _onPanUpdate(details, maxSlide),
                  onPanEnd: _isCompleted
                      ? null
                      : (details) => _onPanEnd(details, maxSlide),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: _buttonWidth.w,
                    height: 52.h,
                    decoration: BoxDecoration(
                      color: _isCompleted
                          ? Colors.green
                          : AppColors.getPrimaryColor(context),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                        BoxShadow(
                          color: AppColors.getPrimaryColor(context)
                              .withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: _isCompleted
                          ? const Icon(
                              FontAwesomeIcons.check,
                              color: Colors.white,
                              size: 20,
                              key: ValueKey('check'),
                            )
                          : const Icon(
                              FontAwesomeIcons.arrowRight,
                              color: Colors.white,
                              size: 16,
                              key: ValueKey('arrow'),
                            ),
                    ),
                  ),
                ),
              ),
              if (_isCompleted)
                AnimatedBuilder(
                  animation: _slideAnimation,
                  builder: (context, child) {
                    return Positioned(
                      left: _dragPosition + 4,
                      top: 4,
                      child: Container(
                        width: (_buttonWidth + 20 * _slideAnimation.value).w,
                        height: (52 + 20 * _slideAnimation.value).h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.green
                                .withOpacity(0.5 * (1 - _slideAnimation.value)),
                            width: 2,
                          ),
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  void _showBookingConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Center(
            child: Text(
              'تم قبول طلب الحجز',
              style: Styles.font20BlackBold(context),
              textAlign: TextAlign.center,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              heightBox(10),
              Icon(
                FontAwesomeIcons.checkCircle,
                color: AppColors.getPrimaryColor(context),
                size: 50.h,
              ),
              heightBox(15),
              Text(
                'سيتم التواصل معك عند قبول الكابتن للحجز',
                style: Styles.font14GreyExtraBold(context),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'حسناً',
                style: TextStyle(
                  color: AppColors.getPrimaryColor(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
