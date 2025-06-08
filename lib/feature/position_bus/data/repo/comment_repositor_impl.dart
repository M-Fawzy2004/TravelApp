
// ignore_for_file: avoid_print

import 'package:travel_app/feature/position_bus/data/model/comment_model.dart';
import 'package:travel_app/feature/position_bus/data/repo/comment_repository.dart';
import 'package:travel_app/feature/position_bus/data/service/comment_service.dart';

class CommentRepositoryImpl implements CommentRepository {
  final CommentService _commentService;

  CommentRepositoryImpl({CommentService? commentService})
      : _commentService = commentService ?? CommentService();

  @override
  Future<bool> addComment({
    required String stationId,
    required String stationName,
    required String comment,
    required double rating,
  }) async {
    try {
      return await _commentService.addComment(
        stationId: stationId,
        stationName: stationName,
        comment: comment,
        rating: rating,
      );
    } catch (e) {
      print('Repository Error - Add Comment: $e');
      return false;
    }
  }

  @override
  Future<List<CommentModel>> getStationComments(String stationId) async {
    try {
      return await _commentService.getStationComments(stationId);
    } catch (e) {
      print('Repository Error - Get Station Comments: $e');
      return [];
    }
  }



  @override
  Future<bool> updateComment({
    required String commentId,
    required String newComment,
    required double newRating,
  }) async {
    try {
      return await _commentService.updateComment(
        commentId: commentId,
        newComment: newComment,
        newRating: newRating,
      );
    } catch (e) {
      print('Repository Error - Update Comment: $e');
      return false;
    }
  }

  @override
  Future<bool> deleteComment(String commentId) async {
    try {
      return await _commentService.deleteComment(commentId);
    } catch (e) {
      print('Repository Error - Delete Comment: $e');
      return false;
    }
  }



  @override
  Future<double> getStationAverageRating(String stationId) async {
    try {
      return await _commentService.getStationAverageRating(stationId);
    } catch (e) {
      print('Repository Error - Get Average Rating: $e');
      return 0.0;
    }
  }

  @override
  Future<int> getStationCommentsCount(String stationId) async {
    try {
      return await _commentService.getStationCommentsCount(stationId);
    } catch (e) {
      print('Repository Error - Get Comments Count: $e');
      return 0;
    }
  }
}