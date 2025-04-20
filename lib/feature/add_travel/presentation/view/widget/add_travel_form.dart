// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/core/widget/custom_text_form_field.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/gradient_selector.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/row_with_label.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/trip_date_time_picker.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/travel_type_selector.dart'; // ✅ استيراد

class AddTravelForm extends StatefulWidget {
  const AddTravelForm({super.key});

  @override
  State<AddTravelForm> createState() => _AddTravelFormState();
}

class _AddTravelFormState extends State<AddTravelForm> {
  String selectedType = 'رحلة خاصة';

  final List<String> travelTypes = [
    'رحلة خاصة',
    'توصيل',
    'شحن أغراض',
  ];

  late LinearGradient selectedGradient = gradientsList[0];

  final List<LinearGradient> gradientsList = [
    LinearGradient(colors: [Color(0xFFE3F2FD), Color(0xFF90CAF9)]),
    LinearGradient(colors: [Color(0xFFFCE4EC), Color(0xFFF48FB1)]),
    LinearGradient(colors: [Color(0xFFE8F5E9), Color(0xFFA5D6A7)]),
    LinearGradient(colors: [Color(0xFFFFF3E0), Color(0xFFFFCC80)]),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        children: [
          RowWithLabel(
            label: 'اختر خلفية',
            widget: GradientSelector(
              gradients: gradientsList,
              selectedGradient: selectedGradient,
              onChanged: (gradient) {
                setState(() {
                  selectedGradient = gradient;
                });
              },
            ),
          ),
          heightBox(10),
          RowWithLabel(
            label: 'نوع الرحلة',
            widget: TravelTypeSelector(
              selectedType: selectedType,
              travelTypes: travelTypes,
              onChanged: (newType) {
                setState(() {
                  selectedType = newType;
                });
              },
            ),
          ),
          heightBox(10),
          RowWithLabel(
            label: 'اسم الوجهة أو عنوان الرحلة',
            widget: CustomTextFormField(
              hintText: 'اسم الوجهة أو عنوان الرحلة',
            ),
          ),
          heightBox(10),
          RowWithLabel(
            label: 'مكان الانطلاق / مكان الوصول',
            widget: Row(
              children: [
                Expanded(
                  child: CustomTextFormField(hintText: 'مكان الانطلاق'),
                ),
                widthBox(10),
                Expanded(
                  child: CustomTextFormField(hintText: 'مكان الوصول'),
                ),
              ],
            ),
          ),
          heightBox(10),
          RowWithLabel(
            label: 'عدد المقاعد الفارغة',
            widget: CustomTextFormField(
              hintText: 'عدد المقاعد الفارغة',
              keyboardType: TextInputType.number,
            ),
          ),
          heightBox(10),
          RowWithLabel(
            label: 'تاريخ الرحلة',
            widget: TripDateTimePicker(),
          ),
          heightBox(10),
          RowWithLabel(
            label: 'المدة المتوقعة / سعر الفرد',
            widget: Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    hintText: 'المدة المتوقعة',
                  ),
                ),
                widthBox(10),
                Expanded(
                  child: CustomTextFormField(
                    hintText: 'سعر الفرد',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ),
          heightBox(10),
          RowWithLabel(
            label: 'تفاصيل إضافية',
            widget: CustomTextFormField(
              maxLines: 5,
              hintText: 'قم بوضع التفاصيل هنا',
            ),
          ),
          heightBox(20),
          CustomButton(
            onPressed: () {},
            buttonText: 'إضافه $selectedType',
            textStyle: Styles.font16WhiteBold,
          ),
        ],
      ),
    );
  }
}
