import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      key: ValueKey(bookingItemEntity.trip.id),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: () {
            context.read<BookingCubit>().removeBooking(bookingItemEntity);
          },
        ),
        children: [
          SlidableAction(
            onPressed: (_) {
              context.read<BookingCubit>().removeBooking(bookingItemEntity);
            },
            backgroundColor: const Color(0xFFFE4A49),
            icon: FontAwesomeIcons.trashAlt,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
            label: 'حذف',
          ),
          SlidableAction(
            onPressed: (_) {},
            backgroundColor: AppColors.getPrimaryColor(context),
            icon: FontAwesomeIcons.share,
            label: 'شارك',
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.getSurfaceColor(context),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            bottomLeft: Radius.circular(20.r),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.getTextColor(context).withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
            BoxShadow(
              color: AppColors.getLightGreyColor(context).withOpacity(0.05),
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
