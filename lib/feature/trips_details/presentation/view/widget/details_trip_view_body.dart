import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/get_user.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/widget/icon_back.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/auth/domain/entity/user_entity.dart';
import 'package:travel_app/feature/trips_details/presentation/view/widget/details_center_card.dart';
import 'package:travel_app/feature/trips_details/presentation/view/widget/details_top_card.dart';
import 'package:travel_app/feature/trips_details/presentation/view/widget/details_trips_text.dart';
import 'package:travel_app/feature/trips_details/presentation/view/widget/edit_and_delete_trips.dart';
import 'package:travel_app/feature/trips_details/presentation/view/widget/ticket_button_bloc_listener.dart';
import 'package:travel_app/feature/trips_details/presentation/view/widget/trip_image_card.dart';

class DetailsTripViewBody extends StatefulWidget {
  const DetailsTripViewBody({
    super.key,
    required this.trip,
  });
  final TripModel trip;

  @override
  State<DetailsTripViewBody> createState() => _DetailsTripViewBodyState();
}

class _DetailsTripViewBodyState extends State<DetailsTripViewBody> {
  bool isFavorited = false;
  @override
  Widget build(BuildContext context) {
    final role = getUser()?.role;
    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 80.h),
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const IconBack(),
                    const Spacer(),
                    Text('تفاصيل الرحلة',
                        style: Styles.font20BlackBold(context)),
                    const Spacer(),
                    widthBox(55),
                  ],
                ),
                heightBox(10),
                TripImageCard(trip: widget.trip),
                heightBox(20),
                DetailsTopCard(
                  trip: widget.trip,
                ),
                heightBox(20),
                DetailsCenterCard(trip: widget.trip),
                heightBox(20),
                if (widget.trip.additionalDetails.isNotEmpty)
                  DetailsTripsText(widget: widget),
                heightBox(20),
              ],
            ),
          ),
        ),
        if (role == UserRole.passenger)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: TicketButtonBlocListener(
              tripModel: widget.trip,
            ),
          ),
        if (role == UserRole.captain)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: EditAndDeleteTrips(
              trip: widget.trip,
            ),
          ),
      ],
    );
  }
}
