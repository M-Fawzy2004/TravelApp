import 'package:flutter/material.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/home/presentation/view/captain_view/view/widget/custom_button_accept.dart';

class NewOrderSection extends StatelessWidget {
  final VoidCallback? onAccept;

  const NewOrderSection({
    super.key,
    this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('محمد فوزى', style: Styles.font16BlackBold(context)),
        const Divider(),
        heightBox(10),
        Row(
          children: [
             Icon(Icons.location_on, color: AppColors.getPrimaryColor(context)),
            widthBox(10),
            Text(
              'كوبرى قصر النيل القاهره',
              style: Styles.font16BlackBold(context).copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        heightBox(20),
        Row(
          children: [
            Expanded(
              flex: 5,
              child: CustomButtonAccept(
                onAccept: onAccept ?? () {},
                title: 'قبول',
              ),
            ),
            widthBox(10),
            Expanded(
              flex: 2,
              child: CustomButtonAccept(
                onAccept: () {},
                title: 'تخطي',
                backgroundColor: AppColors.getLightGreyColor(context),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
