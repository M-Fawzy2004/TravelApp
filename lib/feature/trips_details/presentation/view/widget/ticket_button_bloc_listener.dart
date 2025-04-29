import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/utils/top_snakbar_app.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/trip_booking/presentation/manager/booking_cubit/booking_cubit.dart';
import 'package:travel_app/feature/trip_booking/presentation/manager/booking_cubit/booking_state.dart';
import 'package:travel_app/feature/trips_details/presentation/view/widget/favorite_ticket_button.dart';

class TicketButtonBlocListener extends StatelessWidget {
  const TicketButtonBlocListener({
    super.key,
    required this.tripModel,
  });

  final TripModel tripModel;

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingCubit, BookingState>(
      listener: (context, state) {
        if (state is BookingAdded) {
          showCustomTopSnackBar(
            context: context,
            message: 'تم إضافة الحجز بنجاح',
          );
        } else if (state is BookingFailed) {
          showCustomTopSnackBar(
            context: context,
            message: 'فشل في إضافة الحجز',
          );
        }
        if (state is BookingRemoved) {
          showCustomTopSnackBar(
            context: context,
            message: 'تم حذف الحجز بنجاح',
          );
        }
      },
      child: FavoriteTicketButton(tripModel: tripModel),
    );
  }
}
