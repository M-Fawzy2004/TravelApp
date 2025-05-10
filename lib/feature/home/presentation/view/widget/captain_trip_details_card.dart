import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class CaptainTripDetailsCard extends StatefulWidget {
  const CaptainTripDetailsCard({super.key});

  @override
  State<CaptainTripDetailsCard> createState() => _CaptainTripDetailsCardState();
}

class _CaptainTripDetailsCardState extends State<CaptainTripDetailsCard> {
  String tripStatus = "جار التجهيز";
  bool isTripStarted = false;
  bool isTripEnded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: AppColors.white,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.person, color: Colors.blue),
                widthBox(8),
                const Text(
                  'الراكب : محمد احمد',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            heightBox(12),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.green),
                widthBox(8),
                Expanded(
                  child: Text(
                    'من : باب اللوق',
                    style: Styles.font14GreyExtraBold,
                  ),
                ),
              ],
            ),
            heightBox(8),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.red),
                widthBox(8),
                Expanded(
                  child: Text(
                    'إلى : المعادي',
                    style: Styles.font14GreyExtraBold,
                  ),
                ),
              ],
            ),
            heightBox(12),
            Row(
              children: [
                const Icon(Icons.people, color: Colors.purple),
                widthBox(8),
                Text(
                  'عدد الأفراد: 2',
                  style: Styles.font14DarkGreyBold,
                ),
                const Spacer(),
                const Icon(Icons.attach_money, color: Colors.amber),
                widthBox(8),
                Text(
                  'السعر:50 جنيه',
                  style: Styles.font16BlackBold,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
