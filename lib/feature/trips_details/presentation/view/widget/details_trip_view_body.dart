import 'package:flutter/material.dart';
import 'package:travel_app/core/helper/get_user.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/core/widget/icon_back.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/auth/domain/entity/user_entity.dart';
import 'package:travel_app/feature/trips_details/presentation/view/widget/booking_and_favorite_buttons.dart';
import 'package:travel_app/feature/trips_details/presentation/view/widget/custom_trip_loaction.dart';
import 'package:travel_app/feature/trips_details/presentation/view/widget/details_center_card.dart';
import 'package:travel_app/feature/trips_details/presentation/view/widget/details_header.dart';
import 'package:travel_app/feature/trips_details/presentation/view/widget/details_top_card.dart';
import 'package:travel_app/feature/trips_details/presentation/view/widget/edit_and_delete_trips.dart';

class DetailsTripViewBody extends StatefulWidget {
  const DetailsTripViewBody({
    super.key,
    required this.trip,
    required this.index,
  });
  final TripModel trip;
  final int index;

  @override
  State<DetailsTripViewBody> createState() => _DetailsTripViewBodyState();
}

class _DetailsTripViewBodyState extends State<DetailsTripViewBody> {
  bool isFavorited = false;
  @override
  Widget build(BuildContext context) {
    final role = getUser()?.role;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const IconBack(),
          if (role == UserRole.passenger) const DetailsHeader(),
          DetailsTopCard(
            trip: widget.trip,
            index: widget.index,
          ),
          heightBox(20),
          DetailsCenterCard(trip: widget.trip),
          heightBox(20),
          const CustomTripLocation(),
          heightBox(20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('التفاصيل', style: Styles.font16BlackBold),
              heightBox(10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.trip.additionalDetails,
                  style: Styles.font14GreyExtraBold,
                ),
              ),
            ],
          ),
          if (role == UserRole.passenger)
            Column(
              children: [
                const BookingAndFavoriteButtons(),
                heightBox(10),
                CustomButton(
                  backgroundColor: AppColors.primaryColor,
                  buttonText: 'تواصل مع صاحب الرحله',
                  onPressed: () {},
                ),
              ],
            ),
          if (role == UserRole.captain)
            EditAndDeleteTrips(
              trip: widget.trip,
            ),
        ],
      ),
    );
  }
}

