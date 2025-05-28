import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/trip_booking/domain/entity/booking_item_entity.dart';
import 'package:travel_app/feature/trip_booking/presentation/manager/booking_cubit/booking_cubit.dart';
import 'package:travel_app/feature/trip_booking/presentation/manager/booking_cubit/booking_state.dart';
import 'package:travel_app/feature/trip_booking/presentation/view/widget/custom_trip_icon.dart';

class CounterButtonAndPrice extends StatelessWidget {
  const CounterButtonAndPrice({
    super.key,
    required this.bookingItemEntity,
  });

  final BookingItemEntity bookingItemEntity;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        final currentItem =
            context.read<BookingCubit>().bookingEntity.bookingItems.firstWhere(
                  (item) => item.trip.id == bookingItemEntity.trip.id,
                  orElse: () => bookingItemEntity,
                );

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 45.h,
              decoration: BoxDecoration(
                color: AppColors.getPrimaryColor(context).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: [
                  CustomTripIcon(
                    onPressed: () {
                      context
                          .read<BookingCubit>()
                          .decreaseBookingCount(bookingItemEntity.trip.id);
                    },
                    icon: FontAwesomeIcons.minusCircle,
                  ),
                  Container(
                    width: 35.w,
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    margin: EdgeInsets.symmetric(vertical: 5.h),
                    decoration: BoxDecoration(
                      color: AppColors.getPrimaryColor(context),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        currentItem.count.toString(),
                        style: Styles.font16WhiteBold(context),
                      ),
                    ),
                  ),
                  CustomTripIcon(
                    onPressed: () {
                      context
                          .read<BookingCubit>()
                          .increaseBookingCount(bookingItemEntity.trip.id);
                    },
                    icon: FontAwesomeIcons.plusCircle,
                  )
                ],
              ),
            ),
            Text(
              '${currentItem.calulateTotalPrice()} ج.م',
              style: Styles.font20BlackBold(context),
            ),
          ],
        );
      },
    );
  }
}
