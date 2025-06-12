import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/feature/message/presentation/view/widget/message_title_delegate.dart';
import 'package:travel_app/feature/message/presentation/view/widget/search_chat_text_field.dart';
import 'package:travel_app/feature/message/presentation/view/widget/user_message_card_sliver_list.dart';

class MessageViewBody extends StatefulWidget {
  const MessageViewBody({super.key});

  @override
  State<MessageViewBody> createState() => _MessageViewBodyState();
}

class _MessageViewBodyState extends State<MessageViewBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Scrollbar(
        controller: _scrollController,
        thumbVisibility: false,
        scrollbarOrientation: ScrollbarOrientation.left,
        interactive: true,
        thickness: 2,
        radius: Radius.circular(25.r),
        child: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: MessagesTitleDelegate(),
            ),
            SliverToBoxAdapter(child: heightBox(20)),
            const SliverToBoxAdapter(child: SearchChatTextField()),
            SliverToBoxAdapter(child: heightBox(10)),
            const UserMessageCardSliverList(),
          ],
        ),
      ),
    );
  }
}
