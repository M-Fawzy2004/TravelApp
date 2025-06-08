// comment_model.dart - Updated to include userId
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String id;
  final String stationId;
  final String stationName;
  final String comment;
  final double rating;
  final String ratingText;
  final DateTime createdAt;
  final String userId;
  final String userName; 

  CommentModel({
    required this.id,
    required this.stationId,
    required this.stationName,
    required this.comment,
    required this.rating,
    required this.ratingText,
    required this.createdAt,
    required this.userId,
    required this.userName,
  });

  static String getRatingText(double rating) {
    switch (rating.round()) {
      case 1:
        return 'غير راضي جداً';
      case 2:
        return 'غير راضي';
      case 3:
        return 'مقبول';
      case 4:
        return 'راضي';
      case 5:
        return 'ممتاز';
      default:
        return 'مقبول';
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'stationId': stationId,
      'stationName': stationName,
      'comment': comment,
      'rating': rating,
      'ratingText': ratingText,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'userId': userId,
      'userName': userName,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'] ?? '',
      stationId: map['stationId'] ?? '',
      stationName: map['stationName'] ?? '',
      comment: map['comment'] ?? '',
      rating: (map['rating'] ?? 0.0).toDouble(),
      ratingText: map['ratingText'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0),
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? 'مستخدم',
    );
  }

  factory CommentModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return CommentModel.fromMap(data);
  }

  Map<String, dynamic> toJson() => toMap();

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel.fromMap(json);
  }

  CommentModel copyWith({
    String? id,
    String? stationId,
    String? stationName,
    String? comment,
    double? rating,
    String? ratingText,
    DateTime? createdAt,
    String? userId,
    String? userName,
  }) {
    return CommentModel(
      id: id ?? this.id,
      stationId: stationId ?? this.stationId,
      stationName: stationName ?? this.stationName,
      comment: comment ?? this.comment,
      rating: rating ?? this.rating,
      ratingText: ratingText ?? this.ratingText,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
    );
  }

  @override
  String toString() {
    return 'CommentModel(id: $id, stationId: $stationId, userId: $userId, comment: $comment, rating: $rating, ratingText: $ratingText)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CommentModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
