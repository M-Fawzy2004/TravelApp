import 'package:flutter/material.dart';
import 'package:travel_app/core/theme/styles.dart';

class RideFeeRow extends StatelessWidget {
  const RideFeeRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'رسوم االدفع',
          style: Styles.font16BlackBold,
        ),
        const Spacer(),
        Row(
          children: [
            Text(
              'ج.م 12.0',
              style: Styles.font16BlackBold,
            ),
          ],
        ),
      ],
    );
  }
}
