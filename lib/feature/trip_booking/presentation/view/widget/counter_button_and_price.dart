import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/trip_booking/domain/entity/booking_item_entity.dart';
import 'package:travel_app/feature/trip_booking/presentation/manager/booking_item/booking_item_cubit.dart';
import 'package:travel_app/feature/trip_booking/presentation/view/widget/custom_trip_icon.dart';

class CounterButtonAndPrice extends StatelessWidget {
  const CounterButtonAndPrice({
    super.key,
    required this.bookingItemEntity,
  });

  final BookingItemEntity bookingItemEntity;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            children: [
              CustomTripIcon(
                onPressed: () {
                  if (bookingItemEntity.count >= 2) {
                    bookingItemEntity.decreaseCount();
                  }
                  context
                      .read<BookingItemCubit>()
                      .updateItem(bookingItemEntity);
                },
                icon: FontAwesomeIcons.minusCircle,
              ),
              Container(
                width: 70.w,
                padding: EdgeInsets.symmetric(vertical: 5.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: Text(
                    bookingItemEntity.count.toString(),
                    style: Styles.font16WhiteBold,
                  ),
                ),
              ),
              CustomTripIcon(
                onPressed: () {
                  bookingItemEntity.increaseCount();
                  context
                      .read<BookingItemCubit>()
                      .updateItem(bookingItemEntity);
                },
                icon: FontAwesomeIcons.plusCircle,
              )
            ],
          ),
        ),
        Text(
          '${bookingItemEntity.calulateTotalPrice()} ج.م',
          style: Styles.font20BlackBold,
        ),
      ],
    );
  }
}
