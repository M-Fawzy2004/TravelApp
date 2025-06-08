import 'package:flutter/material.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/core/widget/custom_text_form_field.dart';
import 'package:travel_app/feature/position_bus/data/model/governorate_model.dart';
import 'package:travel_app/feature/position_bus/presentation/view/widget/custom_rating_position.dart';

class StationFeedbackForm extends StatelessWidget {
  const StationFeedbackForm({
    super.key,
    required this.station,
  });

  final Station station;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'تقييم مدى رضاك ب${station.name}',
            style: Styles.font14GreyExtraBold(context),
          ),
          heightBox(10),
          const CustomRatingPosition(),
          heightBox(16),
          const CustomTextFormField(
            hintText: 'اكتب تعليقك هنا',
            maxLines: 3,
          ),
          heightBox(16),
          CustomButton(
            buttonText: 'إضافه تعليق',
            onPressed: () {},
          ),
          heightBox(20),
        ],
      ),
    );
  }
}
