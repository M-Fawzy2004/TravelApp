import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_cubit/trip_cubit.dart';
import 'package:travel_app/feature/home/presentation/view/widget/category_filter_item.dart';

class CategoryFilter extends StatefulWidget {
  const CategoryFilter({super.key});

  @override
  State<CategoryFilter> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategoryFilter> {
  List<String> filterText = [
    'الكل',
    'رحلة خاصه',
    'توصيل',
    'شحن أغراض',
  ];

  int isSelected = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        child: Row(
          children: List.generate(filterText.length, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  isSelected = index;
                });
                _filterTrips(index, context);
              },
              child: CategoryFilterItem(
                text: filterText[index],
                isSelected: isSelected == index,
                color: filterColors[index],
              ),
            );
          }),
        ),
      ),
    );
  }
}

void _filterTrips(int index, BuildContext context) {
  final tripCubit = context.read<TripCubit>();

  switch (index) {
    case 0: // All trips
      tripCubit.getAllTrips();
      break;
    case 1: // Special Trip
      tripCubit.filterTripsByType(TripType.specialTrip);
      break;
    case 2: // Delivery
      tripCubit.filterTripsByType(TripType.delivery);
      break;
    case 3: // Cargo Shipping
      tripCubit.filterTripsByType(TripType.cargoShipping);
      break;
  }
}

List<Color> filterColors = [
  AppColors.primaryColor,
  Colors.blue, // رحلة خاصه
  Colors.green, // توصيل
  Colors.orange, // شحن أغراض
];
