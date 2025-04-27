import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/widget/icon_back.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/add_travel_bloc_consumer.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/add_travel_form.dart';

class AddTravelViewBody extends StatefulWidget {
  const AddTravelViewBody({super.key});

  @override
  State<AddTravelViewBody> createState() => _AddTravelViewBodyState();
}

class _AddTravelViewBodyState extends State<AddTravelViewBody> {
  List<DateTime> eachDateTime = [];
  DateTimeRange? rangeDateTime;

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
              'أهلاً بيك! 👋',
              style: Styles.font18BlackBold,
            ),
          ),
          heightBox(10),
          Text(
            'ضيف تفاصيل رحلتك أو التوصيلة علشان توصل الناس بأمان وسهولة. \nمن فضلك إملأ البيانات بدقة عشان نساعدك توصل للي محتاجين يركبوا معاك.',
            style: Styles.font14GreyExtraBold,
          ),
          heightBox(20),
          AddTravelBlocConsumer(
            builder: (context, state) {
              return const AddTravelForm();
            },
          ),
        ],
      ),
    );
  }
}
