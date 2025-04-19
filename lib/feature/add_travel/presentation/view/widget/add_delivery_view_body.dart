import 'package:flutter/material.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/core/widget/custom_text_form_field.dart';

import 'custom_celendar_date.dart';

class AddDeliveryViewBody extends StatefulWidget {
  const AddDeliveryViewBody({super.key});

  @override
  State<AddDeliveryViewBody> createState() => _AddDeliveryViewBodyState();
}

class _AddDeliveryViewBodyState extends State<AddDeliveryViewBody> {
  List<DateTime?> selectedDates = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heightBox(20),
          CustomTextFormField(
            hintText: 'مكان التوصيل',
          ),
          heightBox(10),
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  hintText: 'المقاعد المتوفره',
                  keyboardType: TextInputType.number,
                ),
              ),
              widthBox(10),
              Expanded(
                child: CustomTextFormField(
                  hintText: 'التوقيت',
                ),
              ),
            ],
          ),
          heightBox(10),
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  hintText: 'المدة',
                ),
              ),
              widthBox(10),
              Expanded(
                child: CustomTextFormField(
                  hintText: 'سعر الفرد',
                ),
              ),
            ],
          ),
          heightBox(20),
          CustomCalendarDate(
            onDateChanged: (dates) {
              setState(() {
                selectedDates = dates;
              });
            },
          ),
          heightBox(20),
          CustomTextFormField(
            hintText: 'تفاصيل المكان',
            maxLines: 3,
          ),
          heightBox(30),
          CustomButton(
            buttonText: 'إضافه',
            textStyle: Styles.font16WhiteBold,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
