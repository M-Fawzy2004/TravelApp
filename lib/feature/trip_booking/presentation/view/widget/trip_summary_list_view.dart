import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/get_user.dart';
import 'package:travel_app/feature/auth/domain/entity/user_entity.dart';
import 'package:travel_app/feature/trip_booking/presentation/view/widget/trip_summary_captain.dart';
import 'package:travel_app/feature/trip_booking/presentation/view/widget/trip_summary_card_bloc_builder.dart';
import 'package:travel_app/feature/trip_booking/domain/entity/booking_item_entity.dart';

class TripSummaryListView extends StatelessWidget {
  const TripSummaryListView({
    super.key,
    required this.booking,
  });

  final List<BookingItemEntity> booking;

  @override
  Widget build(BuildContext context) {
    final role = getUser()?.role;
    return ListView.builder(
      padding: role == UserRole.passenger
          ? EdgeInsets.only(bottom: 240.h)
          : EdgeInsets.zero,
      dragStartBehavior: DragStartBehavior.down,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return role == UserRole.passenger
            ? TripSummaryCardBlocBuilder(
                bookingItemEntity: booking[index],
              )
            : const TripSummaryCaptain();
      },
      itemCount: booking.length,
    );
  }
}
