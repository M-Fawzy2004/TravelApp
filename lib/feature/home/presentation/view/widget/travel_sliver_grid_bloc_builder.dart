import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/utils/top_snakbar_app.dart';
import 'package:travel_app/feature/home/presentation/manager/cubit/connectivity_cubit.dart';
import 'package:travel_app/feature/home/presentation/manager/cubit/connectivity_state.dart';
import 'package:travel_app/feature/home/presentation/view/widget/no_internet_widget.dart';
import 'package:travel_app/feature/home/presentation/view/widget/travel_sliver_grid_bloc_consumer.dart';

class TravelSliverGridBlocConsumer extends StatelessWidget {
  const TravelSliverGridBlocConsumer({super.key});

  void _showNoInternetSnackBar(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showCustomTopSnackBar(
        context: context,
        message: 'لا يوجد اتصال بالإنترنت',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConnectivityCubit, ConnectivityState>(
      listener: (context, connectivityState) {
        final connectivityCubit = context.read<ConnectivityCubit>();

        if (connectivityState is ConnectivityUnavailable &&
            !connectivityCubit.hasShownSnackbar) {
          _showNoInternetSnackBar(context);
          connectivityCubit.setSnackbarShown(true);
        } else if (connectivityState is ConnectivityAvailable) {
          connectivityCubit.setSnackbarShown(false);
        }
      },
      builder: (context, connectivityState) {
        if (connectivityState is ConnectivityUnavailable) {
          return const NoInternetWidget();
        }

        return const TravelSliverGridBlocBuilder();
      },
    );
  }
}
