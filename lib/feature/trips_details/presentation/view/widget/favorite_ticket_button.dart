import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/trip_booking/presentation/manager/booking_cubit/booking_cubit.dart';
import 'package:travel_app/feature/trips_details/presentation/view/widget/contact_captain.dart';
import 'package:travel_app/feature/trips_details/presentation/view/widget/custom_fav_details.dart';

class FavoriteTicketButton extends StatelessWidget {
  const FavoriteTicketButton({
    super.key,
    required this.tripModel,
  });

  final TripModel tripModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 13.h),
      decoration: BoxDecoration(
        color: AppColors.getSurfaceColor(context),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.r),
          topRight: Radius.circular(25.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Expanded(
                flex: 6,
                child: CustomButton(
                  onPressed: () {
                    context.read<BookingCubit>().addBooking(tripModel);
                  },
                  buttonText: 'حجز تذكره',
                ),
              ),
              widthBox(10),
              const Expanded(
                flex: 1,
                child: ContactCaptian(),
              ),
              widthBox(10),
              Expanded(
                flex: 1,
                child: CustomFavDetails(
                  trip: tripModel,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
