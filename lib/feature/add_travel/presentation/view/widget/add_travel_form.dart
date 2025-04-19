import 'package:flutter/material.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/core/widget/custom_text_form_field.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/row_with_label.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/trip_and_delivery_dropdown.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/trip_date_time_picker.dart';

class AddTravelForm extends StatelessWidget {
  const AddTravelForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          label: 'عدد المقاعد الفارغة / نوع الرحلة',
          widget: Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  hintText: 'عدد المقاعد الفارغة',
                  keyboardType: TextInputType.number,
                ),
              ),
              widthBox(10),
              Expanded(
                child: TripAndDeliveryDropdown(),
              ),
            ],
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
          buttonText: 'حفظ',
          textStyle: Styles.font16WhiteBold,
        ),
      ],
    );
  }
}
