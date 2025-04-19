import 'package:flutter/material.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/widget/search_bar_delegate.dart';
import 'package:travel_app/feature/home/presentation/view/widget/category_filter.dart';
import 'package:travel_app/feature/home/presentation/view/widget/category_travel_sliver_list.dart';
import 'package:travel_app/feature/home/presentation/view/widget/details_location.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: heightBox(10),
        ),
        SliverPersistentHeader(
          pinned: true,
          floating: false,
          delegate: SearchBarDelegate(),
        ),
        SliverToBoxAdapter(
          child: DetailsLocation(),
        ),
        SliverToBoxAdapter(
          child: heightBox(20),
        ),
        SliverToBoxAdapter(
          child: CategoryFilter(),
        ),
        SliverToBoxAdapter(
          child: heightBox(20),
        ),
        CategoryTravelListList()
      ],
    );
  }
}
