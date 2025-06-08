import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/widget/custom_loading_circle.dart';
import 'package:travel_app/feature/position_bus/presentation/manager/governorate/governorate_cubit.dart';
import 'package:travel_app/feature/position_bus/presentation/view/widget/poistion_bus_view_body.dart';

class PoistionBusViewBodyBuilder extends StatelessWidget {
  const PoistionBusViewBodyBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GovernorateCubit, GovernorateState>(
      builder: (context, state) {
        if (state is GovernorateLoading) {
          return const Center(child: CustomLoadingCircle());
        } else if (state is GovernorateFailure) {
          return Center(child: Text(state.message));
        } else if (state is GovernorateSuccess) {
          final governorates = state.governorates;
          return PoistionBusViewBody(governorateModel: governorates);
        }
        return const Text('Error');
      },
    );
  }
}
