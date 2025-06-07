import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/services/get_it_setup.dart';
import 'package:travel_app/feature/position_bus/data/repo/governorate_repo_impl.dart';
import 'package:travel_app/feature/position_bus/presentation/manager/cubit/governorate_cubit.dart';
import 'package:travel_app/feature/position_bus/presentation/view/widget/position_bus_view_body_builder.dart';

class PoistionBusView extends StatelessWidget {
  const PoistionBusView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocProvider(
            create: (context) => GovernorateCubit(
              getIt<GovernorateRepoImpl>(),
            ),
            child: const PoistionBusViewBodyBuilder(),
          ),
        ),
      ),
    );
  }
}

