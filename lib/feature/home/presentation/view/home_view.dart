import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/widget/custom_app_bar.dart';
import 'package:travel_app/feature/home/presentation/view/widget/custom_add_travel.dart';
import 'package:travel_app/feature/home/presentation/view/widget/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CustomAppBar(
            title: 'الرئيسيه',
            isAction: true,
            isLeading: true,
            iconAction: IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.bell,
              ),
            ),
            iconLeading: IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.cartShopping,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: CustomAddTravel(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: HomeViewBody(),
      ),
    );
  }
}
