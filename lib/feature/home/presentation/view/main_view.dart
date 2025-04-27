// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/core/helper/app_router.dart';
import 'package:travel_app/core/helper/get_user.dart';
import 'package:travel_app/core/services/auth_service.dart';
import 'package:travel_app/core/services/get_it_setup.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_cubit/trip_cubit.dart';
import 'package:travel_app/feature/auth/domain/entity/user_entity.dart';
import 'package:travel_app/feature/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:travel_app/feature/home/presentation/view/captain_home_view.dart';
import 'package:travel_app/feature/home/presentation/view/passenger_home_view.dart';
import 'package:travel_app/feature/home/presentation/view/widget/custom_bottom_nav_bar.dart';
import 'package:travel_app/feature/message/presentation/view/message_view.dart';
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

    final List<Widget> screens = [
      role == UserRole.passenger
          ? const PassengerHomeView()
          : const CaptainHomeView(),
      const TripBookingView(),
      const MessageView(),
      const NewWidget(),
    ];

    return BlocProvider(
      create: (_) => getIt<TripCubit>()..getAllTrips(),
      child: Scaffold(
        extendBody: true,
        body: Stack(
          children: [
            IndexedStack(
              index: screenIndex,
              children: screens,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0.h,
              child: Center(
                child: CustomBottomNavBar(
                  currentIndex: screenIndex,
                  onTap: (index) {
                    HapticFeedback.lightImpact();
                    setState(() {
                      screenIndex = index;
                    });
                  },
                  role: role!,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = getUser();
    return BlocProvider(
      create: (context) => AuthCubit(
        getIt.get<AuthService>(),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('name: ${user?.firstName}',
                style: Styles.font20ExtraBlackBold),
            Text('data: ${user?.email}', style: Styles.font20ExtraBlackBold),
            Text('role: ${user?.role}', style: Styles.font20ExtraBlackBold),
            Text('data: ${user?.phoneNumber}',
                style: Styles.font20ExtraBlackBold),
            Text('تسجيل الخروج ', style: Styles.font20ExtraBlackBold),
            IconButton(
              onPressed: () async {
                await context.read<AuthCubit>().signOut();
                if (context.mounted) {
                  context.pushReplacement(AppRouter.loginView);
                }
              },
              icon: const Icon(FontAwesomeIcons.rightFromBracket),
            ),
          ],
        ),
      ),
    );
  }
}
