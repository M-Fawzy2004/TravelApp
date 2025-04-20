import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/widget/search_text_field.dart';
import 'package:travel_app/feature/home/presentation/view/widget/category_filter.dart';
import 'package:travel_app/feature/home/presentation/view/widget/category_travel_sliver_grid.dart';
import 'package:travel_app/feature/home/presentation/view/widget/details_location.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: Scrollbar(
        controller: _scrollController,
        thumbVisibility: false,
        scrollbarOrientation: ScrollbarOrientation.right,
        interactive: true,
        thickness: 6,
        radius: Radius.circular(8),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
          child: CustomScrollView(
            controller: _scrollController,
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: heightBox(15)),
              SliverToBoxAdapter(child: SearchTextField()),
              SliverToBoxAdapter(child: heightBox(10)),
              SliverToBoxAdapter(child: DetailsLocation()),
              SliverToBoxAdapter(child: heightBox(20)),
              SliverToBoxAdapter(child: CategoryFilter()),
              SliverToBoxAdapter(child: heightBox(20)),
              CategoryTravelListGrid(),
            ],
          ),
        ),
      ),
    );
  }
}
