// comment_state.dart
import 'package:equatable/equatable.dart';
import 'package:travel_app/feature/position_bus/data/model/comment_model.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object?> get props => [];
}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentSuccess extends CommentState {
  final String message;

  const CommentSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class CommentError extends CommentState {
  final String error;

  const CommentError(this.error);

  @override
  List<Object> get props => [error];
}

class CommentsLoaded extends CommentState {
  final List<CommentModel> comments;
  final double averageRating;
  final int totalComments;

  const CommentsLoaded({
    required this.comments,
    required this.averageRating,
    required this.totalComments,
  });

  @override
  List<Object> get props => [comments, averageRating, totalComments];
}

class UserCommentsLoaded extends CommentState {
  final List<CommentModel> userComments;

  const UserCommentsLoaded(this.userComments);

  @override
  List<Object> get props => [userComments];
}

class CommentOperationSuccess extends CommentState {
  final String message;
  final CommentOperationType operationType;

  const CommentOperationSuccess({
    required this.message,
    required this.operationType,
  });

  @override
  List<Object> get props => [message, operationType];
}

enum CommentOperationType {
  add,
  update,
  delete,
}