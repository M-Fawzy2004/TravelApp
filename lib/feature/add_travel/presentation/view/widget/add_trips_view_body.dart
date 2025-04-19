import 'package:flutter/material.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/core/widget/custom_text_form_field.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/custom_celendar_date.dart';

class AddTripsViewBody extends StatefulWidget {
  const AddTripsViewBody({super.key});

  @override
  State<AddTripsViewBody> createState() => _AddTripsViewBodyState();
}

class _AddTripsViewBodyState extends State<AddTripsViewBody> {
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
            hintText: 'مكان الرحله',
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
            hintText: 'تفاصيل الرحلة',
            maxLines: 7,
          ),
          heightBox(30),
          CustomButton(
            buttonText: 'إضافه الرحله',
            textStyle: Styles.font16WhiteBold,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
