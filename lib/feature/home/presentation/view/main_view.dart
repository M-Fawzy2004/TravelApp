import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_app/core/helper/get_user.dart';
import 'package:travel_app/feature/auth/domain/entity/user_entity.dart';
import 'package:travel_app/feature/home/presentation/view/build_home_screen_by_role.dart';
import 'package:travel_app/feature/home/presentation/view/widget/custom_bottom_nav_bar.dart';
import 'package:travel_app/feature/message/presentation/view/message_view.dart';
import 'package:travel_app/feature/position_bus/presentation/view/poistion_bus_view.dart';
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
    final role = getUser()?.role ?? UserRole.passenger;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        index: screenIndex,
        children: [
          buildHomeScreenByRole(role),
          const TripBookingView(),
          const PoistionBusView(),
          const MessageView(),
          const ProfileView(),
        ],
      ),
      bottomSheet: CustomBottomNavBar(
        currentIndex: screenIndex,
        onTap: (index) {
          HapticFeedback.lightImpact();
          setState(() => screenIndex = index);
        },
        role: role,
      ),
    );
  }
}
