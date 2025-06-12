// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/helper/app_router.dart';
import 'package:travel_app/core/helper/get_user.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/trip_booking/presentation/manager/booking_cubit/booking_cubit.dart';
import 'package:travel_app/feature/trip_booking/presentation/manager/booking_cubit/booking_state.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final getUserName = getUser()?.firstName;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BlocBuilder<BookingCubit, BookingState>(
          builder: (context, state) {
            print('Current booking state: $state');
            int itemsCount = 0;
            if (state is BookingAdded) {
              itemsCount = state.bookings.length;
              print('BookingAdded - Items count: $itemsCount');
            } else if (state is BookingRemoved) {
              itemsCount = state.bookings.length;
              print('BookingRemoved - Items count: $itemsCount');
            }
            return Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  onPressed: () {
                    context.push(AppRouter.tripBooking);
                  },
                  icon: Icon(
                    FontAwesomeIcons.calendar,
                    color: AppColors.getPrimaryColor(context),
                  ),
                ),
                if (itemsCount > 0)
                  Positioned(
                    right: 4,
                    top: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 20,
                        minHeight: 20,
                      ),
                      child: Text(
                        itemsCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
        const Spacer(),
        Text(
          'أهلا بك $getUserName',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Styles.font16BlackBold(context),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: Icon(
            FontAwesomeIcons.solidBell,
            color: AppColors.getPrimaryColor(context),
          ),
        ),
      ],
    );
  }
}