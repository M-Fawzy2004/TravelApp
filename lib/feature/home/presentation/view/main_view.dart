// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/helper/get_user.dart';
import 'package:travel_app/core/services/get_it_setup.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_cubit/trip_cubit.dart';
import 'package:travel_app/feature/auth/domain/entity/user_entity.dart';
import 'package:travel_app/feature/home/presentation/view/captain_delivery_directory/presentation/view/captain_delivery_directory_view.dart';
import 'package:travel_app/feature/home/presentation/view/captain_delivery_directory/presentation/view/record_view.dart';
import 'package:travel_app/feature/home/presentation/view/captain_view/view/captain_home_view.dart';
import 'package:travel_app/feature/home/presentation/view/passenger_view/view/passenger_home_view.dart';
import 'package:travel_app/feature/home/presentation/view/widget/custom_bottom_nav_bar.dart';
import 'package:travel_app/feature/message/presentation/view/message_view.dart';
import 'package:travel_app/feature/profile/presentation/view/profile_view.dart';
import 'package:travel_app/feature/trip_booking/presentation/view/trip_booking_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int screenIndex = 0;

  @override
  Widget build(BuildContext context) {
    final role = getUser()?.role;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          IndexedStack(
            index: screenIndex,
            children: [
              _buildHomeScreen(role),
              if (role == UserRole.captain || role == UserRole.passenger) ...[
                const TripBookingView(),
              ] else ...[
                const RecordView(),
              ],
              const MessageView(),
              const ProfileView(),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Center(
              child: CustomBottomNavBar(
                currentIndex: screenIndex,
                onTap: (index) {
                  HapticFeedback.lightImpact();
                  setState(() {
                    screenIndex = index;
                  });
                },
                role: role ?? UserRole.passenger,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeScreen(UserRole? role) {
    if (role == UserRole.passenger) {
      return BlocProvider(
        create: (_) => getIt<TripCubit>()..getAllTrips(),
        child: const PassengerHomeView(),
      );
    } else if (role == UserRole.captain) {
      return BlocProvider(
        create: (_) =>
            getIt<TripCubit>()..getTripsByCaptainId(getUser()!.id.toString()),
        child: const CaptainHomeView(),
      );
    } else {
      return const CaptainDeliveryDirectoryView();
    }
  }
}
