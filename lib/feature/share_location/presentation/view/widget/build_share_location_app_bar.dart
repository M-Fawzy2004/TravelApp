import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/core/theme/styles.dart';

AppBar buildShareLocationAppBar(BuildContext context) {
  return AppBar(
    elevation: 2,
    scrolledUnderElevation: 0,
    title: Text(
      'مشاركة موقعك',
      style: Styles.font20ExtraBlackBold,
    ),
    centerTitle: true,
    leading: IconButton(
      onPressed: () {
        context.pop();
      },
      icon: const Icon(FontAwesomeIcons.arrowRight),
    ),
    // actions: [
    //   // Clear route button if route is visible
    //   BlocBuilder<LocationCubit, LocationState>(
    //     buildWhen: (previous, current) {
    //       if (previous is LocationLoaded && current is LocationLoaded) {
    //         return previous.isRouteVisible != current.isRouteVisible;
    //       }
    //       return previous != current;
    //     },
    //     builder: (context, state) {
    //       if (state is LocationLoaded && state.isRouteVisible) {
    //         return IconButton(
    //           onPressed: () {
    //             context.read<LocationCubit>().clearRoute();
    //           },
    //           icon: Icon(
    //             FontAwesomeIcons.xmark,
    //             size: 20.sp,
    //           ),
    //           tooltip: 'إزالة المسار',
    //         );
    //       }
    //       return const SizedBox.shrink();
    //     },
    //   ),
    // ],
  );
}
