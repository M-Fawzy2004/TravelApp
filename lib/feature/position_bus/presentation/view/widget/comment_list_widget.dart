// comments_list_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/position_bus/data/model/comment_model.dart';
import 'package:travel_app/feature/position_bus/presentation/manager/cubit/comment_cubit.dart';
import 'package:travel_app/feature/position_bus/presentation/view/widget/comment_item_widget.dart';
import 'package:travel_app/feature/position_bus/presentation/view/widget/section_summary_widget.dart';

class CommentsListWidget extends StatelessWidget {
  final List<CommentModel> comments;
  final String stationId;
  final double averageRating;
  final int totalComments;

  const CommentsListWidget({
    super.key,
    required this.comments,
    required this.stationId,
    required this.averageRating,
    required this.totalComments,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StationRatingSummary(
          averageRating: averageRating,
          totalComments: totalComments,
        ),
        heightBox(16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'التعليقات ($totalComments)',
              style: Styles.font16BlackBold(context),
            ),
            if (comments.isNotEmpty)
              TextButton(
                onPressed: () {
                  context.read<CommentCubit>().getStationComments(stationId);
                },
                child: Text(
                  'تحديث',
                  style: Styles.font14GreyExtraBold(context),
                ),
              ),
          ],
        ),
        heightBox(12),
        if (comments.isEmpty)
          _buildEmptyState(context)
        else
          _buildCommentsList(context),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.getPrimaryColor(context).withOpacity(0.05),
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(
          color: AppColors.getPrimaryColor(context).withOpacity(0.1),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.comment_outlined,
            size: 48.sp,
            color: AppColors.getPrimaryColor(context).withOpacity(0.5),
          ),
          heightBox(12),
          Text(
            'لا توجد تعليقات بعد',
            style: Styles.font16BlackBold(context),
          ),
          heightBox(8),
          Text(
            'كن أول من يضع تعليقاً على هذا الموقف',
            style: Styles.font14GreyExtraBold(context),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCommentsList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: comments.length,
      separatorBuilder: (context, index) => heightBox(12),
      itemBuilder: (context, index) {
        final comment = comments[index];
        return CommentItemWidget(
          comment: comment,
          stationId: stationId,
        );
      },
    );
  }
}
