import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/widget/search_text_field.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_cubit/trip_cubit.dart';
import 'package:travel_app/feature/home/presentation/view/widget/category_filter.dart';
import 'package:travel_app/feature/home/presentation/view/widget/category_travel_sliver_grid_bloc_builder.dart';
import 'package:travel_app/feature/home/presentation/view/widget/details_location.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final ScrollController _scrollController = ScrollController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void dispose() {
    _scrollController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    context.read<TripCubit>().getAllTrips();
    _refreshController.refreshCompleted();
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
          child: SmartRefresher(
            controller: _refreshController,
            onRefresh: _onRefresh,
            enablePullDown: true,
            header: ClassicHeader(
              height: 65.h,
              refreshingText: "جارِ التحديث...",
              releaseText: "إفلت للتحديث",
              completeText: "تم التحديث!",
              failedText: "فشل التحديث!",
              idleText: "اسحب للتحديث",
              iconPos: IconPosition.left,
            ),
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
                SliverToBoxAdapter(child: heightBox(10)),
                CategorySliverGridGridBlocBuilder(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
