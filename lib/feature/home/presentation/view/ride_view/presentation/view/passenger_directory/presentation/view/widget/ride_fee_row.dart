import 'package:flutter/material.dart';
import 'package:travel_app/core/theme/styles.dart';

class RideFeeRow extends StatelessWidget {
  final String fare;
  final String distance;
  final String duration;

  const RideFeeRow({
    super.key,
    required this.fare,
    required this.distance,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text(
              '$fare جنيه',
              style: Styles.font16BlackBold,
            ),
            Text(
              'التكلفة',
              style: Styles.font14GreyExtraBold,
            ),
          ],
        ),
        Column(
          children: [
            Text(
              '$distance كم',
              style: Styles.font16BlackBold,
            ),
            Text(
              'المسافة',
              style: Styles.font14GreyExtraBold,
            ),
          ],
        ),
        Column(
          children: [
            Text(
              '$duration دقيقة',
              style: Styles.font16BlackBold,
            ),
            Text(
              'الوقت',
              style: Styles.font14GreyExtraBold,
            ),
          ],
        ),
      ],
    );
  }
}
