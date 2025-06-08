import '../model/comment_model.dart';

abstract class CommentRepository {
  Future<bool> addComment({
    required String stationId,
    required String stationName,
    required String comment,
    required double rating,
  });

  Future<List<CommentModel>> getStationComments(String stationId);
  Future<bool> updateComment({
    required String commentId,
    required String newComment,
    required double newRating,
  });
  Future<bool> deleteComment(String commentId);
  Future<double> getStationAverageRating(String stationId);
  Future<int> getStationCommentsCount(String stationId);
}
