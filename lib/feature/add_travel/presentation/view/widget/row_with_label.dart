import 'package:flutter/material.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';

class RowWithLabel extends StatelessWidget {
  const RowWithLabel({
    super.key,
    required this.label,
    required this.widget,
  });

  final String label;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Styles.font14GreyExtraBold(context),
        ),
        heightBox(5),
        widget,
      ],
    );
  }
}
