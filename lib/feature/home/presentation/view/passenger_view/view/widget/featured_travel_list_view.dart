import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/utils/assets.dart';
import 'package:travel_app/feature/home/presentation/view/passenger_view/manager/swip/swipe_cubit.dart';
import 'package:travel_app/feature/home/presentation/view/passenger_view/view/widget/featured_travel.dart';
import 'package:travel_app/feature/home/presentation/view/passenger_view/view/widget/view_all_featured_bloc_listener.dart';

class FeaturedTravelListView extends StatefulWidget {
  const FeaturedTravelListView({super.key});

  @override
  State<FeaturedTravelListView> createState() => _FeaturedTravelListViewState();
}

class _FeaturedTravelListViewState extends State<FeaturedTravelListView> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: AppColors.getSurfaceColor(context),
          ),
          child: Center(
            child: Text(
              'الحجوزات والفنادق والأماكن السياحية',
              style: Styles.font16BlackBold(context),
            ),
          ),
        ),
        heightBox(10),
        SizedBox(
          height: 200.h,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            separatorBuilder: (_, __) => widthBox(10),
            itemBuilder: (_, index) {
              if (index == 3) {
                return BlocProvider(
                  create: (context) => SwipeCubit(),
                  child: const ViewAllFeaturedBlocListener(),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.w),
                  child: FeaturedTravel(
                    imagePath: travels[index]['imagePath'],
                    location: travels[index]['location'],
                    country: travels[index]['country'],
                    rating: double.parse(travels[index]['rating']),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
