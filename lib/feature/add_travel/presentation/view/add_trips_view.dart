import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/extension.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/add_trips_view_body.dart';

import '../../../../core/widget/custom_app_bar.dart';

class AddTripsView extends StatelessWidget {
  const AddTripsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CustomAppBar(
            title: 'إضافه رحله',
            isAction: false,
            isLeading: true,
            iconLeading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: AddTripsViewBody(),
      ),
    );
  }
}
