import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/data/repo/ride_repo_impl.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/data/service/ride_service.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/presentation/manager/cubit/ride_cubit.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/presentation/view/passenger_directory/presentation/view/widget/passenger_directory_view_body.dart';

class PassengerDirectoryView extends StatelessWidget {
  const PassengerDirectoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RideCubit(
        RideRepoImpl(
          RideService(),
        ),
      ),
      child: const Scaffold(
        body: SafeArea(child: PassengerDirectoryViewBody()),
      ),
    );
  }
}