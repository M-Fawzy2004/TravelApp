import 'package:flutter/material.dart';
import 'package:travel_app/feature/home/presentation/view/widget/category_travel.dart';

class CategoryTravelListList extends StatelessWidget {
  const CategoryTravelListList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return CategoryTravel();
        },
        childCount: 10,
      ),
    );
  }
}
