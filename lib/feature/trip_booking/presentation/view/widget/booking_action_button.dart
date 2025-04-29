import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/feature/trip_booking/presentation/manager/booking_cubit/booking_cubit.dart';
import 'package:travel_app/feature/trip_booking/presentation/manager/booking_cubit/booking_state.dart';
import 'package:travel_app/feature/trip_booking/presentation/view/widget/action_slider_button.dart';

class BookingActionButton extends StatelessWidget {
  const BookingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        final bookings =
            context.read<BookingCubit>().bookingEntity.bookingItems;

        if (bookings.isEmpty) {
          return const SizedBox();
        }

        return const ActionSliderButton();
      },
    );
  }
}
