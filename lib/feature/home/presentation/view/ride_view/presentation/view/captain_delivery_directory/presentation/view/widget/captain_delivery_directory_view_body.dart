import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/presentation/view/captain_delivery_directory/presentation/view/widget/captain_availability_tile.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/presentation/view/captain_delivery_directory/presentation/view/widget/order_details_sheet.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/presentation/view/captain_delivery_directory/presentation/view/widget/ride_info_card.dart';

class CaptainDeliveryDirectoryViewBody extends StatefulWidget {
  const CaptainDeliveryDirectoryViewBody({super.key});

  @override
  State<CaptainDeliveryDirectoryViewBody> createState() =>
      _CaptainDeliveryDirectoryViewBodyState();
}

class _CaptainDeliveryDirectoryViewBodyState
    extends State<CaptainDeliveryDirectoryViewBody> {
  bool _isOrderAccepted = false;

  void _acceptOrder() {
    setState(() {
      _isOrderAccepted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: Alignment.topCenter,
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          // const RideMapDirectory(),
          Positioned(
            top: 60.h,
            left: 100.w,
            right: 100.w,
            child: const CaptainAvailabilityTile(),
          ),
          if (!_isOrderAccepted)
            Positioned(
              right: 0,
              bottom: 80.h,
              left: 0,
              child: OrderDetailsSheet(
                onAccept: _acceptOrder,
              ),
            ),
          if (_isOrderAccepted)
            Positioned(
              left: 0,
              right: 0,
              bottom: 80.h,
              child: const RideInfoCard(),
            ),
        ],
      ),
    );
  }
}
