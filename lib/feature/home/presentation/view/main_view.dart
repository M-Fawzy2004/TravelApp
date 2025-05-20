import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_app/core/helper/get_user.dart';
import 'package:travel_app/feature/auth/domain/entity/user_entity.dart';
import 'package:travel_app/feature/home/presentation/view/build_home_screen_by_role.dart';
import 'package:travel_app/feature/home/presentation/view/widget/custom_bottom_nav_bar.dart';
import 'package:travel_app/feature/message/presentation/view/message_view.dart';
import 'package:travel_app/feature/profile/presentation/view/profile_view.dart';
import 'package:travel_app/feature/trip_booking/presentation/view/trip_booking_view.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/presentation/view/captain_delivery_directory/presentation/view/record_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int screenIndex = 0;

  @override
  Widget build(BuildContext context) {
    final role = getUser()?.role ?? UserRole.passenger;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          IndexedStack(
            index: screenIndex,
            children: [
              buildHomeScreenByRole(role),
              if (role == UserRole.captain || role == UserRole.passenger)
                const TripBookingView()
              else
                const RecordView(),
              const MessageView(),
              const ProfileView(),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomBottomNavBar(
              currentIndex: screenIndex,
              onTap: (index) {
                HapticFeedback.lightImpact();
                setState(() => screenIndex = index);
              },
              role: role,
            ),
          ),
        ],
      ),
    );
  }
}
