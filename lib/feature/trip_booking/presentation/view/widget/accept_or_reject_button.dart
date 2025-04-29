import 'package:flutter/material.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/widget/custom_button.dart';

class AcceptOrRejectButton extends StatelessWidget {
  const AcceptOrRejectButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            onPressed: () {},
            buttonText: 'قبول',
          ),
        ),
        widthBox(10),
        Expanded(
          child: CustomButton(
            onPressed: () {},
            buttonText: 'رفض',
            backgroundColor: Colors.red,
          ),
        ),
      ],
    );
  }
}
