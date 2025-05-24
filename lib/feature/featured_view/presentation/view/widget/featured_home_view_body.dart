import 'package:flutter/material.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/widget/icon_back.dart';
import 'package:travel_app/feature/featured_view/presentation/view/widget/custom_search_hotel.dart';
import 'package:travel_app/feature/featured_view/presentation/view/widget/featured_travel_card_list_view.dart';

class FeaturedHomeViewBody extends StatelessWidget {
  const FeaturedHomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const IconBack(),
            const Spacer(),
            Text(
              'حجز الفنادق',
              style: Styles.font20BlackBold,
            ),
          ],
        ),
        heightBox(20),
        const CustomSearchHotel(),
        heightBox(20),
        const FeaturedTravelCardListView(),
      ],
    );
  }
}
