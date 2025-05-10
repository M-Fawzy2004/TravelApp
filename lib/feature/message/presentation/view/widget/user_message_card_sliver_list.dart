import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/feature/message/presentation/view/widget/user_message_card.dart';

class UserMessageCardSliverList extends StatelessWidget {
  const UserMessageCardSliverList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(bottom: 85.h),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => const UserMessageCard(),
          childCount: 10,
        ),
      ),
    );
  }
}
