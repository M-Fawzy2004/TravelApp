import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class DetailsMapSection extends StatelessWidget {
  const DetailsMapSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Container(
              color: AppColors.white,
              width: double.infinity,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.map,
                      size: 64,
                      color: Colors.grey,
                    ),
                    heightBox(8),
                    const Text('خريطة موقع الراكب'),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 80.h,
              left: 150,
              child: Row(
                children: [
                  const Icon(
                    Icons.person_pin_circle,
                    color: Colors.red,
                  ),
                  Text(
                    'الراكب',
                    style: Styles.font14GreyExtraBold,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 80,
              right: 100,
              child: Row(
                children: [
                  const Icon(
                    Icons.directions_car,
                    color: Colors.blue,
                  ),
                  Text(
                    'أنت',
                    style: Styles.font14GreyExtraBold,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
