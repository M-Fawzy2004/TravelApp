import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/feature/home/presentation/view/featured_view/presentation/view/widget/featured_travel_card.dart';

class FeaturedTravelCardListView extends StatelessWidget {
  const FeaturedTravelCardListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.w,
          mainAxisSpacing: 8.h,
        ),
        itemCount: 10,
        itemBuilder: (context, index) => const FeaturedTravelCard(),
      ),
    );
  }
}
