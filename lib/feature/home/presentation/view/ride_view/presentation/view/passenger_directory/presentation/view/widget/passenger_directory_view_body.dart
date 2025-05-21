// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/utils/top_snakbar_app.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/presentation/manager/ride_cubit/ride_cubit.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/presentation/manager/ride_cubit/ride_state.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/presentation/view/passenger_directory/presentation/manager/cubit/passenger_directory_cubit.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/presentation/view/passenger_directory/presentation/view/widget/passenger_directory_bloc_builder.dart';

class PassengerDirectoryViewBody extends StatefulWidget {
  const PassengerDirectoryViewBody({super.key});

  @override
  State<PassengerDirectoryViewBody> createState() =>
      _PassengerDirectoryViewBodyState();
}

class _PassengerDirectoryViewBodyState
    extends State<PassengerDirectoryViewBody> {
  final TextEditingController _destinationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<PassengerDirectoryCubit>().getCurrentLocation();
  }

  @override
  void dispose() {
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RideCubit, RideState>(
      listener: (context, state) {
        if (state is RideFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is RideSuccess && state.ride != null) {
          showCustomTopSnackBar(
            context: context,
            message: 'تم إنشاء طلب التوصيل بنجاح',
          );
        }
      },
      child: const PassengerDirectoryBlocBuilder(),
    );
  }
}
