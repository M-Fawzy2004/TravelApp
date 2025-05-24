import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/feature/featured_view/presentation/view/widget/featured_home_view_body.dart';

class FeaturedHomeView extends StatelessWidget {
  const FeaturedHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: const FeaturedHomeViewBody(),
        ),
      ),
    );
  }
}
