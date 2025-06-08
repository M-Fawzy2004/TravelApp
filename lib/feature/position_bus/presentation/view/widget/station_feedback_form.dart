// station_feedback_form.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/utils/top_snakbar_app.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/core/widget/custom_text_form_field.dart';
import 'package:travel_app/feature/position_bus/data/model/governorate_model.dart';
import 'package:travel_app/feature/position_bus/presentation/manager/cubit/comment_cubit.dart';
import 'package:travel_app/feature/position_bus/presentation/manager/cubit/comment_state.dart';
import 'package:travel_app/feature/position_bus/presentation/view/widget/comment_list_widget.dart';
import 'package:travel_app/feature/position_bus/presentation/view/widget/custom_rating_position.dart';

class StationFeedbackForm extends StatefulWidget {
  const StationFeedbackForm({
    super.key,
    required this.station,
  });

  final Station station;

  @override
  State<StationFeedbackForm> createState() => _StationFeedbackFormState();
}

class _StationFeedbackFormState extends State<StationFeedbackForm> {
  final TextEditingController _commentController = TextEditingController();
  double _currentRating = 3.0;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    // Load comments when widget initializes
    context.read<CommentCubit>().getStationComments(widget.station.name);
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _submitComment() async {
    if (_commentController.text.trim().isEmpty) {
      showCustomTopSnackBar(message: 'يرجى كتابة تعليق', context: context);
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    await context.read<CommentCubit>().addComment(
          stationId: widget.station.name,
          stationName: widget.station.name,
          comment: _commentController.text.trim(),
          rating: _currentRating,
        );

    setState(() {
      _isSubmitting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommentCubit, CommentState>(
      listener: (context, state) {
        if (state is CommentOperationSuccess) {
          showCustomTopSnackBar(message: state.message, context: context);
          if (state.operationType == CommentOperationType.add) {
            _commentController.clear();
            _currentRating = 3.0;
          }
        } else if (state is CommentError) {
          showCustomTopSnackBar(message: state.error, context: context);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'تقييم مدى رضاك ب${widget.station.name}',
            style: Styles.font14GreyExtraBold(context),
          ),
          heightBox(10),
          CustomRatingPosition(
            initialRating: _currentRating,
            onRatingUpdate: (rating) {
              setState(() {
                _currentRating = rating;
              });
            },
          ),
          heightBox(16),
          CustomTextFormField(
            controller: _commentController,
            hintText: 'اكتب تعليقك هنا',
            maxLines: 3,
          ),
          heightBox(16),
          CustomButton(
            buttonText: _isSubmitting ? 'جارٍ الإضافة...' : 'إضافه تعليق',
            onPressed: _isSubmitting ? null : _submitComment,
          ),
          heightBox(20),
          // Comments Section
          BlocBuilder<CommentCubit, CommentState>(
            builder: (context, state) {
              if (state is CommentLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CommentsLoaded) {
                return CommentsListWidget(
                  comments: state.comments,
                  stationId: widget.station.name,
                  averageRating: state.averageRating,
                  totalComments: state.totalComments,
                );
              } else if (state is CommentError) {
                return Center(
                  child: Column(
                    children: [
                      Text(
                        'حدث خطأ في تحميل التعليقات',
                        style: Styles.font14GreyExtraBold(context),
                      ),
                      heightBox(8),
                      TextButton(
                        onPressed: () {
                          context
                              .read<CommentCubit>()
                              .getStationComments(widget.station.name);
                        },
                        child: Text('إعادة المحاولة'),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
