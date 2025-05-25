import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/styles.dart';

class OrLogin extends StatelessWidget {
  const OrLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            endIndent: 15.w,
          ),
        ),
        Text(
          'أو',
          style: Styles.font16BlackBold(context),
        ),
        Expanded(
          child: Divider(
            indent: 15.w,
          ),
        ),
      ],
    );
  }
}
