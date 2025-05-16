import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/feature/home/presentation/view/captain_delivery_directory/presentation/view/widget/new_order_section.dart';

class NewOrderSectionListView extends StatelessWidget {
  const NewOrderSectionListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.h,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) => const NewOrderSection(),
      ),
    );
  }
}
