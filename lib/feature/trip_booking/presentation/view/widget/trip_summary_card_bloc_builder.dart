import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:travel_app/feature/trip_booking/domain/entity/booking_item_entity.dart';
import 'package:travel_app/feature/trip_booking/presentation/manager/booking_item/booking_item_cubit.dart';
import 'package:travel_app/feature/trip_booking/presentation/view/widget/trip_summary_card.dart';

class TripSummaryCardBlocBuilder extends StatelessWidget {
  const TripSummaryCardBlocBuilder({
    super.key,
    required this.bookingItemEntity,
  });

  final BookingItemEntity bookingItemEntity;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingItemCubit, BookingItemState>(
      buildWhen: (previous, current) {
        if (current is BookingItemUpdated) {
          if (current.bookingItemEntity == bookingItemEntity) {
            return true;
          }
        }
        return false;
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(bottom: 5.h),
          child: TripSummaryCard(
            bookingItemEntity: bookingItemEntity,
          ),
        );
      },
    );
  }
}
