import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:chat_bubbles/date_chips/date_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class ConversationList extends StatefulWidget {
  const ConversationList({
    super.key,
  });

  @override
  State<ConversationList> createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  // Test messages for demonstration
  final List<Map<String, dynamic>> messages = [
    {
      'text': 'أهلا بيك ي فندم فى رحلتنا',
      'isSender': false,
      'time': DateTime.now().subtract(const Duration(days: 1, hours: 2)),
    },
    {
      'text': 'شكرا جزيلا، ممكن تساعدني في معرفة المزيد عن الرحلة؟',
      'isSender': true,
      'time': DateTime.now().subtract(const Duration(days: 1, hours: 1)),
    },
    {
      'text': 'بالتأكيد، الرحلة ستكون لمدة 5 أيام و4 ليالي في شرم الشيخ',
      'isSender': false,
      'time': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'text': 'رائع! ما هي البرامج المتاحة خلال الرحلة؟',
      'isSender': true,
      'time': DateTime.now().subtract(const Duration(hours: 23)),
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      itemCount: messages.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return DateChip(
            color: AppColors.grey,
            date: DateTime.now().subtract(const Duration(days: 1)),
          );
        }
        final messageIndex = index - 1;
        final message = messages[messageIndex];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: BubbleSpecialOne(
            text: message['text'],
            isSender: message['isSender'],
            tail: true,
            color: message['isSender']
                ? AppColors.primaryColor
                : AppColors.lightGrey.withOpacity(0.3),
            textStyle: message['isSender']
                ? Styles.font16WhiteBold
                : Styles.font16BlackBold,
          ),
        );
      },
    );
  }
}
