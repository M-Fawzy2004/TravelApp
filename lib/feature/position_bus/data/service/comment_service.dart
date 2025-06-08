// ignore_for_file: avoid_print, avoid_types_as_parameter_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/constant.dart';
import '../model/comment_model.dart';
import 'package:travel_app/core/helper/get_user.dart';

class CommentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add comment to Firebase
  Future<bool> addComment({
    required String stationId,
    required String stationName,
    required String comment,
    required double rating,
  }) async {
    try {
      if (stationId.isEmpty || comment.trim().isEmpty) {
        print('Invalid input: stationId or comment is empty');
        return false;
      }
      final commentId = _firestore.collection(kCollection).doc().id;
      final currentUser = getUser();
      final commentModel = CommentModel(
        id: commentId,
        stationId: stationId,
        stationName: stationName,
        comment: comment.trim(),
        rating: rating.clamp(0.0, 5.0),
        ratingText: CommentModel.getRatingText(rating.clamp(0.0, 5.0)),
        createdAt: DateTime.now(),
        userId: currentUser?.id ?? '',
        userName:
            '${currentUser?.firstName ?? ''} ${currentUser?.lastName ?? ''}'
                .trim(),
      );
      await _firestore
          .collection(kCollection)
          .doc(commentId)
          .set(commentModel.toMap());

      print('Comment added successfully: $commentId');
      return true;
    } catch (e) {
      print('Error adding comment: $e');
      return false;
    }
  }

  // Get comments without orderBy to avoid index requirement
  Future<List<CommentModel>> getStationComments(String stationId) async {
    try {
      if (stationId.isEmpty) {
        print('Station ID is empty');
        return [];
      }
      print('Fetching comments for station: $stationId');
      final querySnapshot = await _firestore
          .collection(kCollection)
          .where('stationId', isEqualTo: stationId)
          .get();
      print(
          'Found ${querySnapshot.docs.length} documents for station: $stationId');
      if (querySnapshot.docs.isEmpty) {
        print('No comments found for station: $stationId');
        return [];
      }
      final comments = <CommentModel>[];
      for (var doc in querySnapshot.docs) {
        try {
          print('Processing document: ${doc.id} with data: ${doc.data()}');
          final comment = CommentModel.fromFirestore(doc);
          comments.add(comment);
        } catch (e) {
          print('Error parsing comment document ${doc.id}: $e');
        }
      }
      comments.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      print('Successfully returning ${comments.length} comments');
      return comments;
    } catch (e) {
      print('Error getting comments for station $stationId: $e');
      return [];
    }
  }

  // Alternative method using index-friendly approach
  Future<List<CommentModel>> getStationCommentsWithIndex(
      String stationId) async {
    try {
      if (stationId.isEmpty) return [];
      final querySnapshot = await _firestore
          .collection(kCollection)
          .where('stationId', isEqualTo: stationId)
          .orderBy('createdAt', descending: true)
          .get();
      return querySnapshot.docs
          .map((doc) => CommentModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error getting comments with index: $e');
      return getStationComments(stationId);
    }
  }

  // Update comment in Firebase
  Future<bool> updateComment({
    required String commentId,
    required String newComment,
    required double newRating,
  }) async {
    try {
      if (commentId.isEmpty || newComment.trim().isEmpty) {
        print('Invalid input for update');
        return false;
      }

      final updateData = {
        'comment': newComment.trim(),
        'rating': newRating.clamp(0.0, 5.0),
        'ratingText': CommentModel.getRatingText(newRating.clamp(0.0, 5.0)),
      };

      await _firestore
          .collection(kCollection)
          .doc(commentId)
          .update(updateData);

      print('Comment updated successfully: $commentId');
      return true;
    } catch (e) {
      print('Error updating comment: $e');
      return false;
    }
  }

  // Delete comment from Firebase
  Future<bool> deleteComment(String commentId) async {
    try {
      if (commentId.isEmpty) {
        print('Comment ID is empty');
        return false;
      }

      await _firestore.collection(kCollection).doc(commentId).delete();
      print('Comment deleted successfully: $commentId');
      return true;
    } catch (e) {
      print('Error deleting comment: $e');
      return false;
    }
  }

  // Get average rating for a station
  Future<double> getStationAverageRating(String stationId) async {
    try {
      if (stationId.isEmpty) return 0.0;

      final comments = await getStationComments(stationId);
      if (comments.isEmpty) return 0.0;

      final totalRating = comments.fold<double>(
        0.0,
        (sum, comment) => sum + comment.rating.clamp(0.0, 5.0),
      );

      final average = totalRating / comments.length;
      return double.parse(average.toStringAsFixed(1));
    } catch (e) {
      print('Error getting average rating: $e');
      return 0.0;
    }
  }

  // Get comments count for a station
  Future<int> getStationCommentsCount(String stationId) async {
    try {
      if (stationId.isEmpty) return 0;

      final comments = await getStationComments(stationId);
      return comments.length;
    } catch (e) {
      print('Error getting comments count: $e');
      return 0;
    }
  }

  // Real-time stream without orderBy
  Stream<List<CommentModel>> getStationCommentsStream(String stationId) {
    if (stationId.isEmpty) {
      return Stream.value([]);
    }

    return _firestore
        .collection(kCollection)
        .where('stationId', isEqualTo: stationId)
        .snapshots()
        .map((snapshot) {
      try {
        final comments = <CommentModel>[];

        for (var doc in snapshot.docs) {
          try {
            final comment = CommentModel.fromFirestore(doc);
            comments.add(comment);
          } catch (e) {
            print('Error parsing comment in stream: $e');
          }
        }
        comments.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        return comments;
      } catch (e) {
        print('Error in comments stream: $e');
        return <CommentModel>[];
      }
    }).handleError((error) {
      print('Stream error: $error');
      return <CommentModel>[];
    });
  }

  // Alternative stream method that uses index (requires composite index)
  Stream<List<CommentModel>> getStationCommentsStreamWithIndex(
      String stationId) {
    if (stationId.isEmpty) {
      return Stream.value([]);
    }
    return _firestore
        .collection(kCollection)
        .where('stationId', isEqualTo: stationId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CommentModel.fromFirestore(doc))
            .toList())
        .handleError((error) {
      print('Stream with index error: $error');
      return getStationCommentsStream(stationId);
    });
  }

  // Method to check collection name and debug
  Future<void> debugCollection() async {
    try {
      print('Collection name: $kCollection');
      final snapshot = await _firestore.collection(kCollection).limit(1).get();
      print('Collection exists: ${snapshot.docs.isNotEmpty}');

      if (snapshot.docs.isNotEmpty) {
        print('Sample document: ${snapshot.docs.first.data()}');
      } else {
        print('Collection is empty');
      }
      final testDoc =
          await _firestore.collection(kCollection).doc('test').get();
      print('Test document exists: ${testDoc.exists}');
    } catch (e) {
      print('Debug collection error: $e');
    }
  }

  // Method to validate data structure
  Future<bool> validateCommentData(Map<String, dynamic> data) async {
    try {
      final requiredFields = [
        'id',
        'stationId',
        'comment',
        'rating',
        'createdAt'
      ];
      for (String field in requiredFields) {
        if (!data.containsKey(field) || data[field] == null) {
          print('Missing required field: $field');
          return false;
        }
      }
      if (data['rating'] is! num || data['rating'] < 0 || data['rating'] > 5) {
        print('Invalid rating value: ${data['rating']}');
        return false;
      }
      if (data['comment'] is! String ||
          data['comment'].toString().trim().isEmpty) {
        print('Invalid comment value: ${data['comment']}');
        return false;
      }
      return true;
    } catch (e) {
      print('Error validating comment data: $e');
      return false;
    }
  }
}
