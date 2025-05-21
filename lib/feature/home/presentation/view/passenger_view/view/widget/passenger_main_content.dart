import 'package:flutter/material.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/feature/home/presentation/view/passenger_view/view/widget/direct_ride_request_button.dart';
import 'package:travel_app/feature/home/presentation/view/passenger_view/view/widget/featured_travel_list_view.dart';
import 'package:travel_app/feature/home/presentation/view/widget/category_filter.dart';
import 'package:travel_app/feature/home/presentation/view/widget/details_location.dart';

class PassengerMainContent extends StatelessWidget {
  const PassengerMainContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DetailsLocation(),
        heightBox(10),
        const DirectRideRequestButton(),
        heightBox(10),
        const FeaturedTravelListView(),
        heightBox(20),
        const Align(
          alignment: Alignment.centerRight,
          child: CategoryFilter(),
        ),
        heightBox(10),
      ],
    );
  }
}
