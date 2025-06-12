import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/position_bus/data/model/governorate_model.dart';
import 'package:travel_app/feature/position_bus/presentation/view/widget/expandable_stations_list.dart';

class GovernorateCard extends StatefulWidget {
  const GovernorateCard({
    super.key,
    required this.name,
    required this.stations,
  });

  final String name;
  final List<Station> stations;

  @override
  State<GovernorateCard> createState() => _GovernorateCardState();
}

class _GovernorateCardState extends State<GovernorateCard> {
  bool isExpanded = false;
  final GlobalKey _contentKey = GlobalKey();
  double contentHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateContentHeight();
    });
  }

  void _calculateContentHeight() {
    if (_contentKey.currentContext != null) {
      final RenderBox renderBox =
          _contentKey.currentContext!.findRenderObject() as RenderBox;
      setState(() {
        contentHeight = renderBox.size.height;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: AppColors.getBackgroundColor(context),
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(
          color: AppColors.getPrimaryColor(context).withOpacity(0.1),
        ),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              height: 50.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.getPrimaryColor(context).withOpacity(0.1),
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.name,
                      style: Styles.font16BlackBold(context),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: 24.w,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ExpandableStationsList(isExpanded: isExpanded, widget: widget),
        ],
      ),
    );
  }
}
