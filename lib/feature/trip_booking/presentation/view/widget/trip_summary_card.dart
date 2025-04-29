import 'package:flutter/material.dart';
import 'package:travel_app/feature/trip_booking/domain/entity/booking_item_entity.dart';
import 'package:travel_app/feature/trip_booking/presentation/manager/booking_cubit/booking_cubit.dart';
import 'package:travel_app/feature/trip_booking/presentation/view/widget/counter_button_and_price.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/feature/trip_booking/presentation/view/widget/trip_summary_card_header.dart';

class TripSummaryCard extends StatelessWidget {
  const TripSummaryCard({
    super.key,
    required this.bookingItemEntity,
  });

  final BookingItemEntity bookingItemEntity;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {}),
        children: [
          SlidableAction(
            onPressed: (value) {
              context.read<BookingCubit>().removeBooking(bookingItemEntity);
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
            label: 'حذف',
          ),
          SlidableAction(
            onPressed: (value) {},
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            icon: Icons.share,
            label: 'شارك',
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            bottomLeft: Radius.circular(20.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TripSummaryCardHeader(
              bookingItemEntity: bookingItemEntity,
            ),
            heightBox(12),
            CounterButtonAndPrice(
              bookingItemEntity: bookingItemEntity,
            ),
          ],
        ),
      ),
    );
  }
}
