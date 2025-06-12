// edit_comment_dialog.dart - Fixed Version
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/utils/top_snakbar_app.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/core/widget/custom_text_form_field.dart';
import 'package:travel_app/feature/position_bus/data/model/comment_model.dart';
import 'package:travel_app/feature/position_bus/presentation/manager/cubit/comment_cubit.dart';
import 'package:travel_app/feature/position_bus/presentation/manager/cubit/comment_state.dart';
import 'package:travel_app/feature/position_bus/presentation/view/widget/custom_rating_position.dart';

class EditCommentDialog extends StatefulWidget {
  final CommentModel comment;
  final String stationId;

  const EditCommentDialog({
    super.key,
    required this.comment,
    required this.stationId,
  });

  @override
  State<EditCommentDialog> createState() => _EditCommentDialogState();
}

class _EditCommentDialogState extends State<EditCommentDialog> {
  late TextEditingController _commentController;
  late double _currentRating;
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController(text: widget.comment.comment);
    _currentRating = widget.comment.rating;
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _updateComment() async {
    if (_commentController.text.trim().isEmpty) {
      showCustomTopSnackBar(message: 'يرجى كتابة تعليق', context: context);
      return;
    }
    if (!mounted) return;
    setState(() {
      _isUpdating = true;
    });
    await context.read<CommentCubit>().updateComment(
          commentId: widget.comment.id,
          newComment: _commentController.text.trim(),
          newRating: _currentRating,
          stationId: widget.stationId,
        );
    if (mounted) {
      setState(() {
        _isUpdating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommentCubit, CommentState>(
      listener: (context, state) {
        if (state is CommentOperationSuccess &&
            state.operationType == CommentOperationType.update) {
          if (mounted) {
            Navigator.pop(context);
            showCustomTopSnackBar(message: state.message, context: context);
          }
        } else if (state is CommentError) {
          if (mounted) {
            showCustomTopSnackBar(message: state.error, context: context);
          }
        }
      },
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'تعديل التعليق',
                      style: Styles.font16BlackBold(context),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              heightBox(16),
              Text(
                'التقييم:',
                style: Styles.font14GreyExtraBold(context),
              ),
              heightBox(8),
              CustomRatingPosition(
                initialRating: _currentRating,
                onRatingUpdate: (rating) {
                  if (mounted) {
                    setState(() {
                      _currentRating = rating;
                    });
                  }
                },
              ),
              heightBox(16),
              Text(
                'التعليق:',
                style: Styles.font14GreyExtraBold(context),
              ),
              heightBox(8),
              CustomTextFormField(
                controller: _commentController,
                hintText: 'اكتب تعليقك هنا',
                maxLines: 4,
              ),
              heightBox(20),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed:
                          _isUpdating ? null : () => Navigator.pop(context),
                      child: Text(
                        'إلغاء',
                        style: Styles.font14GreyExtraBold(context),
                      ),
                    ),
                  ),
                  widthBox(12),
                  Expanded(
                    flex: 2,
                    child: CustomButton(
                      buttonText:
                          _isUpdating ? 'جارٍ التحديث...' : 'تحديث التعليق',
                      onPressed: _isUpdating ? null : _updateComment,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
