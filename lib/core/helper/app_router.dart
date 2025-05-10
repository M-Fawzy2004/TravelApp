import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/add_travel/presentation/view/add_travel_view.dart';
import 'package:travel_app/feature/home/presentation/view/trip_tracking_view.dart';
import 'package:travel_app/feature/message/presentation/view/chat_view.dart';
import 'package:travel_app/feature/message/presentation/view/message_view.dart';
import 'package:travel_app/feature/profile/presentation/view/profile_view.dart';
import 'package:travel_app/feature/share_location/presentation/view/share_location_view.dart';
import 'package:travel_app/feature/trip_booking/presentation/view/trip_booking_view.dart';
import 'package:travel_app/feature/trips_details/presentation/view/details_trip_view.dart';
import 'package:travel_app/feature/home/presentation/view/main_view.dart';
import 'package:travel_app/feature/auth/presentation/view/login_view.dart';
import 'package:travel_app/feature/auth/presentation/view/otp_verification_view.dart';
import 'package:travel_app/feature/onboarding/onboarding_view.dart';
import 'package:travel_app/feature/user_profile/view/user_profile.dart';

abstract class AppRouter {
  static const loginView = '/loginView';
  static const otpVerf = '/otpVerf';
  static const mainView = '/mainView';
  static const userProfile = '/userProfile';
  static const addTravel = '/addTravel';
  static const detailsTrip = '/detailsTrip';
  static const passengerHomeView = '/passengerHomeView';
  static const tripBooking = '/tripBooking';
  static const messageView = '/messageView';
  static const chatView = '/chatView';
  static const profileView = '/profileView';
  static const shareLocationView = '/shareLocationView';
  static const tripTrackingView = '/tripTrackingView';

  static var router = GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final user = FirebaseAuth.instance.currentUser;
      final isLoggedIn = user != null;
      final isAtRoot = state.matchedLocation == '/';
      final isAtLogin = state.matchedLocation == loginView;
      final isAtOtp = state.matchedLocation == otpVerf;

      if (isLoggedIn && (isAtRoot || isAtLogin || isAtOtp)) {
        return mainView;
      }

      if (!isLoggedIn && !isAtRoot && !isAtLogin && !isAtOtp) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const OnboardingView();
        },
      ),
      GoRoute(
        path: loginView,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginView();
        },
      ),
      GoRoute(
        path: otpVerf,
        builder: (context, state) {
          final verificationId = state.extra as String;
          return OtpVerificationView(verificationId: verificationId);
        },
      ),
      GoRoute(
        path: mainView,
        builder: (BuildContext context, GoRouterState state) {
          return const MainView();
        },
      ),
      GoRoute(
        path: userProfile,
        builder: (BuildContext context, GoRouterState state) {
          return const UserProfile();
        },
      ),
      GoRoute(
        path: addTravel,
        builder: (BuildContext context, GoRouterState state) {
          return const AddTravelView();
        },
      ),
      GoRoute(
        path: detailsTrip,
        builder: (BuildContext context, GoRouterState state) {
          final extra = GoRouterState.of(context).extra as Map<String, dynamic>;
          final trip = extra['trip'] as TripModel;
          final index = extra['index'] as int;
          return DetailsTripView(
            trip: trip,
            index: index,
          );
        },
      ),
      GoRoute(
        path: tripBooking,
        builder: (BuildContext context, GoRouterState state) {
          return const TripBookingView();
        },
      ),
      GoRoute(
        path: messageView,
        builder: (BuildContext context, GoRouterState state) {
          return const MessageView();
        },
      ),
      GoRoute(
        path: profileView,
        builder: (BuildContext context, GoRouterState state) {
          return const ProfileView();
        },
      ),
      GoRoute(
        path: chatView,
        builder: (BuildContext context, GoRouterState state) {
          return const ChatView();
        },
      ),
      GoRoute(
        path: shareLocationView,
        builder: (BuildContext context, GoRouterState state) {
          return const ShareLocationView();
        },
      ),
      GoRoute(
        path: tripTrackingView,
        builder: (BuildContext context, GoRouterState state) {
          return const TripTrackingView();
        },
      ),
    ],
  );
}
