import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/feature/position_bus/data/model/governorate_model.dart';
import 'package:travel_app/feature/position_bus/presentation/view/widget/list_view_governorate_card.dart';
import 'package:travel_app/feature/position_bus/presentation/view/widget/search_position_bus_field.dart';

class PoistionBusViewBody extends StatelessWidget {
  const PoistionBusViewBody({super.key, required this.governorateModel});

  final List<GovernorateModel> governorateModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heightBox(10),
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            "مرحبًا بك في قسم المواقف",
            style: Styles.font16BlackBold(context).copyWith(
              color: AppColors.darkPrimaryColor,
            ),
          ),
        ),
        heightBox(10),
        Text(
          "هدفنا:\n- نخلّيك عارف السعر التقريبي قبل ما تركب.\n- نساعدك تختار أسرع وأنسب وسيلة.\n- ولو مش عارف تروح فين، هنقولك تركب إيه بالضبط.",
          style: Styles.font14GreyExtraBold(context),
        ),
        heightBox(10),
        Text(
          'بحث سريع : ',
          style: Styles.font16BlackBold(context).copyWith(
            color: AppColors.darkPrimaryColor,
          ),
        ),
        heightBox(10),
        Row(
          children: [
            const Expanded(
              child: SearchPoistionBusField(
                hintText: 'من : ',
              ),
            ),
            widthBox(10),
            const Expanded(
              child: SearchPoistionBusField(
                hintText: 'إلى : ',
              ),
            ),
          ],
        ),
        heightBox(10),
        CustomButton(
          buttonText: 'ابحث',
          onPressed: () {},
          buttonHeight: 45.h,
          backgroundColor: AppColors.darkPrimaryColor.withOpacity(.9),
        ),
        heightBox(10),
        Text(
          "أختر المحافظه ثم الموقف اللى هتركب منه : ",
          style: Styles.font16BlackBold(context).copyWith(
            color: AppColors.darkPrimaryColor,
          ),
        ),
        heightBox(10),
        ListViewGovernorateCard(governorates: governorateModel),
        heightBox(80),
      ],
    );
  }
}
