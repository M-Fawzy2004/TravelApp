abstract class SwipeState {}

class SwipeInitial extends SwipeState {}

class SwipeDragging extends SwipeState {
  final double progress;
  final double offset;
  final bool canComplete;
  
  SwipeDragging({
    required this.progress,
    required this.offset,
    required this.canComplete,
  });
}

class SwipeCompleting extends SwipeState {}

class SwipeCompleted extends SwipeState {}

class SwipeReset extends SwipeState {}