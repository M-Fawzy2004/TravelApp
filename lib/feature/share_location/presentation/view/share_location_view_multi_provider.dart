import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/feature/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:travel_app/feature/share_location/data/data_source/address_data_source.dart';
import 'package:travel_app/feature/share_location/data/data_source/location_data_source.dart';
import 'package:travel_app/feature/share_location/data/repos/address_repo.dart';
import 'package:travel_app/feature/share_location/data/repos/location_repo.dart';
import 'package:travel_app/feature/share_location/presentation/manager/address/address_cubit.dart';
import 'package:travel_app/feature/share_location/presentation/manager/location/location_cubit.dart';
import 'package:travel_app/feature/share_location/presentation/view/share_location_view.dart';

class ShareLocationViewMultiProvider extends StatelessWidget {
  const ShareLocationViewMultiProvider({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: authCubit,
        ),
        BlocProvider(
          create: (context) => AddressCubit(
            addressRepository: AddressRepository(
              dataSource: AddressDataSource(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => LocationCubit(
            locationRepository: LocationRepository(
              locationDataSource: LocationDataSource(),
            ),
          ),
        ),
      ],
      child: const ShareLocationView(),
    );
  }
}
