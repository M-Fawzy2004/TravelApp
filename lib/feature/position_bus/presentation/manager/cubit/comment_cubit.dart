// comment_cubit.dart - With Debug Information
// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/feature/position_bus/data/model/comment_model.dart';
import 'package:travel_app/feature/position_bus/data/repo/comment_repositor_impl.dart';
import 'package:travel_app/feature/position_bus/data/repo/comment_repository.dart';
import 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  final CommentRepository _commentRepository;

  CommentCubit({CommentRepository? commentRepository})
      : _commentRepository = commentRepository ?? CommentRepositoryImpl(),
        super(CommentInitial());

  // Add comment with debug info
  Future<void> addComment({
    required String stationId,
    required String stationName,
    required String comment,
    required double rating,
  }) async {
    print('CommentCubit: Adding comment for station $stationId'); // Debug
    emit(CommentLoading());

    try {
      final success = await _commentRepository.addComment(
        stationId: stationId,
        stationName: stationName,
        comment: comment,
        rating: rating,
      );

      print('CommentCubit: Add comment success: $success'); // Debug

      if (success) {
        emit(const CommentOperationSuccess(
          message: 'تم إضافة التعليق بنجاح',
          operationType: CommentOperationType.add,
        ));
        // Wait a bit for Firestore to sync
        await Future.delayed(const Duration(milliseconds: 500));
        await getStationComments(stationId);
      } else {
        emit(const CommentError('فشل في إضافة التعليق'));
      }
    } catch (e) {
      print('CommentCubit: Add comment error: $e'); // Debug
      emit(CommentError('حدث خطأ: ${e.toString()}'));
    }
  }

  // Get station comments with debug info
  Future<void> getStationComments(String stationId) async {
    print('CommentCubit: Getting comments for station $stationId'); // Debug
    emit(CommentLoading());

    try {
      final comments = await _commentRepository.getStationComments(stationId);
      print('CommentCubit: Retrieved ${comments.length} comments'); // Debug

      final averageRating =
          await _commentRepository.getStationAverageRating(stationId);
      print('CommentCubit: Average rating: $averageRating'); // Debug

      final totalComments =
          await _commentRepository.getStationCommentsCount(stationId);
      print('CommentCubit: Total comments: $totalComments'); // Debug

      // Debug: Print each comment
      for (int i = 0; i < comments.length; i++) {
        print('Comment $i: ${comments[i].comment} by ${comments[i].userName}');
      }

      emit(CommentsLoaded(
        comments: comments,
        averageRating: averageRating,
        totalComments: totalComments,
      ));
    } catch (e) {
      print('CommentCubit: Get comments error: $e'); // Debug
      emit(CommentError('فشل في تحميل التعليقات: ${e.toString()}'));
    }
  }

  // Update comment
  Future<void> updateComment({
    required String commentId,
    required String newComment,
    required double newRating,
    required String stationId,
  }) async {
    print('CommentCubit: Updating comment $commentId'); // Debug
    emit(CommentLoading());

    try {
      final success = await _commentRepository.updateComment(
        commentId: commentId,
        newComment: newComment,
        newRating: newRating,
      );

      if (success) {
        emit(const CommentOperationSuccess(
          message: 'تم تحديث التعليق بنجاح',
          operationType: CommentOperationType.update,
        ));
        // Wait a bit for Firestore to sync
        await Future.delayed(const Duration(milliseconds: 500));
        await getStationComments(stationId);
      } else {
        emit(const CommentError('فشل في تحديث التعليق'));
      }
    } catch (e) {
      print('CommentCubit: Update comment error: $e'); // Debug
      emit(CommentError('حدث خطأ في التحديث: ${e.toString()}'));
    }
  }

  // Delete comment
  Future<void> deleteComment({
    required String commentId,
    required String stationId,
  }) async {
    print('CommentCubit: Deleting comment $commentId'); // Debug
    emit(CommentLoading());

    try {
      final success = await _commentRepository.deleteComment(commentId);

      if (success) {
        emit(const CommentOperationSuccess(
          message: 'تم حذف التعليق بنجاح',
          operationType: CommentOperationType.delete,
        ));
        // Wait a bit for Firestore to sync
        await Future.delayed(const Duration(milliseconds: 500));
        await getStationComments(stationId);
      } else {
        emit(const CommentError('فشل في حذف التعليق'));
      }
    } catch (e) {
      print('CommentCubit: Delete comment error: $e'); // Debug
      emit(CommentError('حدث خطأ في الحذف: ${e.toString()}'));
    }
  }

  void resetState() {
    emit(CommentInitial());
  }

  List<CommentModel> getCurrentComments() {
    if (state is CommentsLoaded) {
      return (state as CommentsLoaded).comments;
    }
    return [];
  }

  double getCurrentAverageRating() {
    if (state is CommentsLoaded) {
      return (state as CommentsLoaded).averageRating;
    }
    return 0.0;
  }

  int getCurrentTotalComments() {
    if (state is CommentsLoaded) {
      return (state as CommentsLoaded).totalComments;
    }
    return 0;
  }

  // Debug method to check collection
  Future<void> debugCollection() async {
    try {
      // Call debug method from service
      // await (_commentRepository as CommentRepositoryImpl)._commentService.debugCollection();
    } catch (e) {
      print('Debug collection error: $e');
    }
  }
}
