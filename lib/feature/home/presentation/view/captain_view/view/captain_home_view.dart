import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/get_user.dart';
import 'package:travel_app/core/services/get_it_setup.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_cubit/trip_cubit.dart';
import 'package:travel_app/feature/home/presentation/view/captain_view/view/widget/captain_home_view_body.dart';
import 'package:travel_app/feature/home/presentation/view/captain_view/view/widget/custom_add_travel.dart';

class CaptainHomeView extends StatelessWidget {
  const CaptainHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<TripCubit>()..getTripsByCaptainId(getUser()!.id.toString()),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 70.h),
          child: const CustomAddTravel(),
        ),
        body: const SafeArea(
          child: CaptainHomeViewBody(),
        ),
      ),
    );
  }
}
