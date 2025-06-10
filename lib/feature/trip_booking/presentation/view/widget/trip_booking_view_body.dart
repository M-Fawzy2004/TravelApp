import 'package:flutter/material.dart';
import 'package:travel_app/core/helper/get_user.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/feature/auth/domain/entity/user_entity.dart';
import 'package:travel_app/feature/trip_booking/presentation/view/widget/booking_action_button.dart';
import 'package:travel_app/feature/trip_booking/presentation/view/widget/favorite_trips_bloc_consumer.dart';
import 'package:travel_app/feature/trip_booking/presentation/view/widget/trip_booking_header.dart';
import 'package:travel_app/feature/trip_booking/presentation/view/widget/trip_summary_list_bloc_buider.dart';

class TripBookingViewBody extends StatefulWidget {
  const TripBookingViewBody({super.key});

  @override
  State<TripBookingViewBody> createState() => _TripBookingViewBodyState();
}

class _TripBookingViewBodyState extends State<TripBookingViewBody> {
  bool _showFavoritesOnly = false;

  void toggleFavorites(bool isFavoriteMode) {
    setState(() {
      _showFavoritesOnly = isFavoriteMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final role = getUser()?.role;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                heightBox(10),
                if (role == UserRole.passenger)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TripBookingHeader(
                      onFavoriteToggle: toggleFavorites,
                      initialFavoriteMode: _showFavoritesOnly,
                    ),
                  ),
                if (_showFavoritesOnly)
                  const Expanded(child: FavoriteTripsBlocConsumer())
                else
                  const Expanded(child: TripSummaryListBlocBuilder()),
              ],
            ),
          ),
          if (role == UserRole.passenger && !_showFavoritesOnly)
            const Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              child: BookingActionButton(),
            ),
        ],
      ),
    );
  }
}
