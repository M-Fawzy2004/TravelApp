import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/presentation/view/passenger_directory/presentation/manager/cubit/passenger_directory_cubit.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/presentation/view/passenger_directory/presentation/view/widget/ride_request_content.dart';

class PassengerDirectoryBlocBuilder extends StatelessWidget {
  const PassengerDirectoryBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PassengerDirectoryCubit, PassengerDirectoryState>(
      builder: (context, state) {
        if (state is PassengerDirectoryInitial ||
            state is PassengerDirectoryLoading) {
          return Center(
            child: SpinKitCircle(
              color: AppColors.primaryColor,
              size: 50.h,
            ),
          );
        } else if (state is PassengerDirectoryError) {
          return const Center(child: Text('حدث خطأ برجاء المحاولة مرة اخرى'));
        } else if (state is PassengerDirectoryLoaded) {
          return RideRequestContent(state: state);
        }
        return const Center(
          child: Text('حالة غير متوقعة'),
        );
      },
    );
  }
}
