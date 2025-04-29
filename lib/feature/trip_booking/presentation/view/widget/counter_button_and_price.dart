import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/feature/trip_booking/domain/entity/booking_item_entity.dart';
import 'package:travel_app/feature/trip_booking/presentation/manager/booking_item/booking_item_cubit.dart';

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
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  if (bookingItemEntity.count >= 2) {
                    bookingItemEntity.decreaseCount();
                  }
                  context
                      .read<BookingItemCubit>()
                      .updateItem(bookingItemEntity);
                },
                icon: const Icon(
                  Icons.remove,
                  color: AppColors.primaryColor,
                ),
              ),
              Text(
                bookingItemEntity.count.toString(),
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              IconButton(
                onPressed: () {
                  bookingItemEntity.increaseCount();
                  context
                      .read<BookingItemCubit>()
                      .updateItem(bookingItemEntity);
                },
                icon: const Icon(
                  Icons.add,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
        Text(
          '${bookingItemEntity.calulateTotalPrice()} ج.م',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
