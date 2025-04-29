import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/services/get_it_setup.dart';
import 'package:travel_app/feature/trip_booking/presentation/manager/booking_item/booking_item_cubit.dart';
import 'package:travel_app/feature/trip_booking/presentation/view/widget/trip_booking_view_body.dart';
import 'package:travel_app/feature/trip_booking/presentation/manager/booking_cubit/booking_cubit.dart';

class TripBookingView extends StatelessWidget {
  const TripBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<BookingCubit>(),
      child: BlocProvider(
        create: (context) => BookingItemCubit(),
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: const TripBookingViewBody(),
            ),
          ),
        ),
      ),
    );
  }
}
