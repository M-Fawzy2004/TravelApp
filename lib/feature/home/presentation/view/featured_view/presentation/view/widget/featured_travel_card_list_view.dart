import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/utils/assets.dart';
import 'package:travel_app/feature/home/presentation/view/passenger_view/view/widget/featured_travel.dart';

class FeaturedTravelCardListView extends StatefulWidget {
  const FeaturedTravelCardListView({super.key});

  @override
  State<FeaturedTravelCardListView> createState() =>
      _FeaturedTravelCardListViewState();
}

class _FeaturedTravelCardListViewState
    extends State<FeaturedTravelCardListView> {
  List travels = [
    {
      'location': 'شرم الشيخ',
      'imagePath': Assets.imagesHotel,
      'country': '1000 ج.م',
      'rating': '5',
    },
    {
      'location': 'التجمع الخامس',
      'imagePath': Assets.imagesHotel2,
      'country': '1500 ج.م',
      'rating': '4.8',
    },
    {
      'location': 'الشيخ زايد',
      'imagePath': Assets.imagesHotel3,
      'country': '3000 ج.م',
      'rating': '4.4',
    }
  ];
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
        itemCount: travels.length,
        itemBuilder: (context, index) => FeaturedTravel(
          imagePath: travels[index]['imagePath'],
          location: travels[index]['location'],
          country: travels[index]['country'],
          rating: double.parse(travels[index]['rating']),
        ),
      ),
    );
  }
}
