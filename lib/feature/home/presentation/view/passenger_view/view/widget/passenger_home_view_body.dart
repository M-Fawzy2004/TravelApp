// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/widget/search_bar_delegate.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_cubit/trip_cubit.dart';
import 'package:travel_app/feature/home/presentation/view/passenger_view/view/widget/direct_ride_request_button.dart';
import 'package:travel_app/feature/home/presentation/view/widget/details_location.dart';
import 'package:travel_app/feature/home/presentation/view/passenger_view/view/widget/featured_travel_list_view.dart';
import 'package:travel_app/feature/home/presentation/view/widget/category_filter.dart';
import 'package:travel_app/feature/home/presentation/view/widget/travel_sliver_grid_bloc_builder.dart';

class PassengerHomeViewBody extends StatefulWidget {
  const PassengerHomeViewBody({super.key});

  @override
  State<PassengerHomeViewBody> createState() => _PassengerHomeViewBodyState();
}

class _PassengerHomeViewBodyState extends State<PassengerHomeViewBody> {
  final ScrollController _scrollController = ScrollController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  bool _firstBuild = true;
  String selectedTripType = 'توصيل مباشر';

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    Future.microtask(() {
      context.read<TripCubit>().getAllTrips();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_firstBuild) {
      _firstBuild = false;
      Future.microtask(() async {
        final result = ModalRoute.of(context)?.settings.arguments;
        if (result == true) {
          await _onRefresh();
        }
      });
    }
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
        scrollbarOrientation: ScrollbarOrientation.left,
        interactive: true,
        thickness: 4,
        radius: const Radius.circular(8),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
          child: SmartRefresher(
            controller: _refreshController,
            onRefresh: _onRefresh,
            enablePullDown: true,
            header: ClassicHeader(
              height: 65.h,
              refreshStyle: RefreshStyle.Follow,
              refreshingText: "جارِ التحديث...",
              releaseText: "إفلت للتحديث",
              completeText: "تم التحديث!",
              failedText: "فشل التحديث!",
              idleText: "اسحب للتحديث",
              iconPos: IconPosition.left,
            ),
            child: CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SearchBarDelegate(
                    hintText: 'أبحث عن رحله معينه....',
                  ),
                ),
                SliverToBoxAdapter(child: heightBox(20)),
                const SliverToBoxAdapter(child: DetailsLocation()),
                SliverToBoxAdapter(child: heightBox(10)),
                const SliverToBoxAdapter(
                  child: DirectRideRequestButton(),
                ),
                SliverToBoxAdapter(child: heightBox(10)),
                const SliverToBoxAdapter(child: FeaturedTravelListView()),
                SliverToBoxAdapter(child: heightBox(20)),
                const SliverToBoxAdapter(
                  child: CategoryFilter(),
                ),
                SliverToBoxAdapter(child: heightBox(10)),
                const TravelSliverGridBlocConsumer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
