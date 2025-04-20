import 'package:flutter/material.dart';
import 'package:travel_app/core/theme/styles.dart';

class ResentlyAddedViewBody extends StatelessWidget {
  const ResentlyAddedViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            'قريبا يتم الاضافة',
            style: Styles.font20ExtraBlackBold,
          ),
        )
      ],
    );
  }
}
