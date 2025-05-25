import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/widget/icon_back.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/add_travel_bloc_consumer.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/edit_travel_form.dart';

class EditTravelViewBody extends StatelessWidget {
  final TripModel trip;

  const EditTravelViewBody({
    super.key,
    required this.trip,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heightBox(20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: const IconBack(),
          ),
          heightBox(20),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'تعديل الرحلة',
              style: Styles.font18BlackBold(context),
            ),
          ),
          heightBox(10),
          Text(
            'يمكنك تعديل تفاصيل رحلتك هنا. يرجى التأكد من صحة البيانات المدخلة.',
            style: Styles.font14GreyExtraBold(context),
          ),
          heightBox(20),
          AddTravelBlocConsumer(
            builder: (context, state) {
              return EditTravelForm(trip: trip);
            },
          ),
        ],
      ),
    );
  }
}
