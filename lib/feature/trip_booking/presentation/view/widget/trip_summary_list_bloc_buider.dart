import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/feature/trip_booking/presentation/view/widget/trip_summary_list_view.dart';
import 'package:travel_app/feature/trips_details/presentation/manager/booking_cubit/booking_cubit.dart';

class TripSummaryListBlocBuilder extends StatefulWidget {
  const TripSummaryListBlocBuilder({
    super.key,
  });

  @override
  State<TripSummaryListBlocBuilder> createState() =>
      _TripSummaryListBlocBuilderState();
}

class _TripSummaryListBlocBuilderState
    extends State<TripSummaryListBlocBuilder> {
  @override
  void initState() {
    super.initState();
    context.read<BookingCubit>().loadBookingsFromPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        final bookings =
            context.read<BookingCubit>().bookingEntity.bookingItems;

        return Expanded(
          child: bookings.isEmpty
              ? const Center(child: Text("لا يوجد حجوزات بعد"))
              : TripSummaryListView(
                  booking: bookings,
                ),
        );
      },
    );
  }
}
