// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/utils/top_snakbar_app.dart';
import 'package:travel_app/feature/position_bus/data/model/comment_model.dart';
import 'package:travel_app/core/helper/get_user.dart';
import 'package:travel_app/feature/position_bus/presentation/manager/cubit/comment_cubit.dart';
import 'package:travel_app/feature/position_bus/presentation/view/widget/edit_comment_dialog.dart';

class CommentItemWidget extends StatefulWidget {
  final CommentModel comment;
  final String stationId;

  const CommentItemWidget({
    super.key,
    required this.comment,
    required this.stationId,
  });

  @override
  State<CommentItemWidget> createState() => _CommentItemWidgetState();
}

class _CommentItemWidgetState extends State<CommentItemWidget> {
  bool _isLiked = false;
  int _likesCount = 0;

  @override
  void initState() {
    super.initState();
    _likesCount = 0;
  }

  bool _isMyComment() {
    try {
      final currentUser = getUser();
      return currentUser?.id == widget.comment.userId;
    } catch (e) {
      print('Error checking if my comment: $e');
      return false;
    }
  }

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (context) => EditCommentDialog(
        comment: widget.comment,
        stationId: widget.stationId,
      ),
    );
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(
          'حذف التعليق',
          style: Styles.font16BlackBold(context).copyWith(
            fontFamily: 'font',
          ),
        ),
        content: Text(
          'هل أنت متأكد من حذف هذا التعليق؟',
          style: Styles.font14GreyExtraBold(context),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<CommentCubit>().deleteComment(
                    commentId: widget.comment.id,
                    stationId: widget.stationId,
                  );
            },
            child: const Text(
              'حذف',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleLike() {
    setState(() {
      if (_isLiked) {
        _likesCount--;
        _isLiked = false;
      } else {
        _likesCount++;
        _isLiked = true;
      }
    });
  }

  void _showReplyDialog() {
    showCustomTopSnackBar(message: 'ميزة الرد قيد التطوير', context: context);
  }

  @override
  Widget build(BuildContext context) {
    final isMyComment = _isMyComment();
    
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.getPrimaryColor(context).withOpacity(0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor:
                    AppColors.getPrimaryColor(context).withOpacity(0.1),
                child: Text(
                  _getUserInitials(),
                  style: Styles.font14GreyExtraBold(context),
                ),
              ),
              widthBox(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getUserName(),
                      style: Styles.font14GreyExtraBold(context),
                    ),
                    Text(
                      _formatDate(widget.comment.createdAt),
                      style: Styles.font12GreyExtraBold(context),
                    ),
                  ],
                ),
              ),
              // Rating stars - Fixed to handle invalid rating values
              Row(
                children: List.generate(5, (index) {
                  final rating = widget.comment.rating.clamp(0.0, 5.0);
                  return Icon(
                    index < rating.round() ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 16.sp,
                  );
                }),
              ),
            ],
          ),
          heightBox(12),
          Text(
            widget.comment.comment.isNotEmpty ? widget.comment.comment : 'لا يوجد تعليق',
            style: Styles.font14GreyExtraBold(context),
          ),
          heightBox(12),
          Row(
            children: [
              if (isMyComment) ...[
                TextButton.icon(
                  onPressed: _showEditDialog,
                  icon: Icon(
                    Icons.edit,
                    size: 16.sp,
                    color: AppColors.getPrimaryColor(context),
                  ),
                  label: Text(
                    'تعديل',
                    style: TextStyle(
                      color: AppColors.getPrimaryColor(context),
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: _showDeleteConfirmation,
                  icon: Icon(
                    Icons.delete,
                    size: 16.sp,
                    color: Colors.red,
                  ),
                  label: Text(
                    'حذف',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ] else ...[
                TextButton.icon(
                  onPressed: _toggleLike,
                  icon: Icon(
                    _isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                    size: 16.sp,
                    color: _isLiked
                        ? AppColors.getPrimaryColor(context)
                        : Colors.grey,
                  ),
                  label: Text(
                    'إعجاب ($_likesCount)',
                    style: TextStyle(
                      color: _isLiked
                          ? AppColors.getPrimaryColor(context)
                          : Colors.grey,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: _showReplyDialog,
                  icon: Icon(
                    Icons.reply,
                    size: 16.sp,
                    color: Colors.grey,
                  ),
                  label: Text(
                    'رد',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  String _getUserName() {
    try {
      final currentUser = getUser();
      if (widget.comment.userId == currentUser?.id) {
        final firstName = currentUser?.firstName ?? '';
        final lastName = currentUser?.lastName ?? '';
        final fullName = '$firstName $lastName'.trim();
        return fullName.isNotEmpty ? fullName : 'مستخدم';
      }
      return widget.comment.userName.isNotEmpty
          ? widget.comment.userName
          : 'مستخدم';
    } catch (e) {
      print('Error getting user name: $e');
      return 'مستخدم';
    }
  }

  String _getUserInitials() {
    try {
      final name = _getUserName();
      if (name.trim().isEmpty || name == 'مستخدم') return 'م';
      
      final parts = name.trim().split(' ');
      if (parts.length >= 2 && parts[0].isNotEmpty && parts[1].isNotEmpty) {
        return '${parts[0][0]}${parts[1][0]}';
      } else if (parts.isNotEmpty && parts[0].isNotEmpty) {
        return parts[0][0];
      }
      return 'م';
    } catch (e) {
      print('Error getting user initials: $e');
      return 'م';
    }
  }

  String _formatDate(DateTime date) {
    try {
      final now = DateTime.now();
      final difference = now.difference(date);
      
      if (difference.inDays > 7) {
        return '${date.day}/${date.month}/${date.year}';
      } else if (difference.inDays > 0) {
        return 'منذ ${difference.inDays} ${difference.inDays == 1 ? 'يوم' : 'أيام'}';
      } else if (difference.inHours > 0) {
        return 'منذ ${difference.inHours} ${difference.inHours == 1 ? 'ساعة' : 'ساعات'}';
      } else if (difference.inMinutes > 0) {
        return 'منذ ${difference.inMinutes} ${difference.inMinutes == 1 ? 'دقيقة' : 'دقائق'}';
      } else {
        return 'الآن';
      }
    } catch (e) {
      print('Error formatting date: $e');
      return 'تاريخ غير محدد';
    }
  }
}