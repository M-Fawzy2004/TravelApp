import 'package:flutter/material.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class PoistionBusViewBody extends StatelessWidget {
  const PoistionBusViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heightBox(10),
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            "مرحبًا بك في قسم أسعار المواقف",
            style: Styles.font16BlackBold(context).copyWith(
              color: AppColors.darkPrimaryColor,
            ),
          ),
        ),
        heightBox(10),
        Text(
          "هنا هتلاقي الأسعار الحقيقية للميكروباصات والمواصلات في مواقف مصر، من غير لف ودوران ولا نصب ",
          style: Styles.font14GreyExtraBold(context),
        ),
        heightBox(10),
        Text(
          "هدفنا:\n- نخلّيك عارف السعر قبل ما تركب.\n- نساعدك تختار أسرع وأنسب وسيلة.\n- ولو مش عارف تروح فين، هنقولك تركب إيه بالضبط.",
          style: Styles.font14GreyExtraBold(context),
        ),
        heightBox(10),
        Text(
          "أختر محافظه : ",
          style: Styles.font16BlackBold(context).copyWith(
            color: AppColors.darkPrimaryColor,
          ),
        ),
        heightBox(10),
        heightBox(80),
      ],
    );
  }
}
