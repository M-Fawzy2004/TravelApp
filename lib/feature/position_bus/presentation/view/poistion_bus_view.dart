import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/feature/position_bus/presentation/view/widget/poistion_bus_view_body.dart';

class PoistionBusView extends StatelessWidget {
  const PoistionBusView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: const PoistionBusViewBody(),
        ),
      ),
    );
  }
}
