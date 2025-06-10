// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:travel_app/core/widget/search_bar_delegate.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_cubit/trip_cubit.dart';
import 'package:travel_app/feature/home/presentation/view/passenger_view/view/widget/passenger_main_content.dart';
import 'package:travel_app/feature/home/presentation/view/widget/app_header.dart';
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: Scrollbar(
        controller: _scrollController,
        thumbVisibility: false,
        scrollbarOrientation: ScrollbarOrientation.left,
        interactive: true,
        thickness: 2.r,
        radius: const Radius.circular(8),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
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
                const SliverToBoxAdapter(child: AppHeader()),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SearchBarDelegate(
                    hintText: 'أبحث عن رحله معينه....',
                  ),
                ),
                const SliverToBoxAdapter(
                  child: PassengerMainContent(),
                ),
                const TravelSliverGridBlocConsumer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
}
