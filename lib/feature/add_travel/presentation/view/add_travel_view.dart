import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/add_travel_view_body.dart';

class AddTravelView extends StatelessWidget {
  const AddTravelView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: AddTravelViewBody(),
        ),
      ),
    );
  }
}
