import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    'توصيل خاص',
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
    case 0:
      tripCubit.getAllTrips();
      break;
    case 1: 
      tripCubit.filterTripsByType(TripType.specialTrip);
      break;
    case 2:
      tripCubit.filterTripsByType(TripType.privateDelivery);
      break;
  }
}
