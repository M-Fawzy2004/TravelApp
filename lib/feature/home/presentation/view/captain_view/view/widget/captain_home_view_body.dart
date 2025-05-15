import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:travel_app/core/helper/get_user.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_cubit/trip_cubit.dart';
import 'package:travel_app/feature/home/presentation/view/captain_view/view/widget/captain_home_header.dart';
import 'package:travel_app/feature/home/presentation/view/captain_view/view/widget/captain_trip_type_selector.dart';
import 'package:travel_app/feature/home/presentation/view/widget/category_travel_sliver_grid_bloc_builder.dart';
import 'package:travel_app/feature/home/presentation/view/captain_view/view/widget/custom_trip_form_captain.dart';
import 'package:travel_app/feature/home/presentation/view/captain_view/view/widget/details_location.dart';

class CaptainHomeViewBody extends StatefulWidget {
  const CaptainHomeViewBody({super.key});

  @override
  State<CaptainHomeViewBody> createState() => _CaptainHomeViewBodyState();
}

class _CaptainHomeViewBodyState extends State<CaptainHomeViewBody> {
  final ScrollController _scrollController = ScrollController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  String selectedTripType = 'توصيل مباشر';

  @override
  void initState() {
    super.initState();
    // Load trips after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCaptainTrips();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> _loadCaptainTrips() async {
    final userId = getUser()?.id;
    if (userId != null) {
      await context.read<TripCubit>().getTripsByCaptainId(userId.toString());
    }
  }

  Future<void> _onRefresh() async {
    try {
      await _loadCaptainTrips();
      if (mounted) {
        _refreshController.refreshCompleted();
      }
    } catch (e) {
      if (mounted) {
        _refreshController.refreshFailed();
      }
    }
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
              height: 70.h,
              refreshingText: "جارِ التحديث...",
              releaseText: "إفلت للتحديث",
              completeText: "تم التحديث!",
              failedText: "فشل التحديث!",
              idleText: "اسحب للتحديث",
              iconPos: IconPosition.left,
              textStyle: Styles.font16BlackBold.copyWith(
                color: AppColors.primaryColor,
                fontFamily: 'font',
              ),
            ),
            child: CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(child: heightBox(15)),
                const SliverToBoxAdapter(child: CaptainHomeHeader()),
                SliverToBoxAdapter(child: heightBox(20)),
                const SliverToBoxAdapter(child: DetailsLocation()),
                SliverToBoxAdapter(child: heightBox(20)),
                SliverToBoxAdapter(
                  child: CaptainTripTypeSelector(
                    selectedTripType: selectedTripType,
                    onTripTypeChanged: (value) {
                      setState(() {
                        selectedTripType = value;
                      });
                    },
                  ),
                ),
                SliverToBoxAdapter(child: heightBox(10)),
                _buildTripContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTripContent() {
    if (selectedTripType == 'رحلاتي') {
      return const CategorySliverGridGridBlocBuilder();
    } else {
      return SliverToBoxAdapter(
        child: SizedBox(
          height: 500.h, // Define a fixed height
          child: const CustomTripFormCaptain(),
        ),
      );
    }
  }
}
