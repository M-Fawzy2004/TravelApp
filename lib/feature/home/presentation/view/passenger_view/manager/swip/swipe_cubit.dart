import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:travel_app/feature/home/presentation/view/passenger_view/manager/swip/swipe_state.dart';

class SwipeCubit extends Cubit<SwipeState> {
  SwipeCubit() : super(SwipeInitial());

  double _dragOffset = 0.0;
  double _maxDragDistance = 0.0;
  bool _navigated = false;
  bool _isResetting = false;

  void setMaxDragDistance(double distance) {
    _maxDragDistance = distance;
  }

  void startDrag() {
    if (!_navigated && !_isResetting) {
      HapticFeedback.selectionClick();
    }
  }

  void updateDrag(double delta) {
    if (_navigated || _isResetting) return;
    double newOffset = (_dragOffset + delta).clamp(0.0, _maxDragDistance);
    _dragOffset = newOffset;
    double progress = _maxDragDistance > 0 ? _dragOffset / _maxDragDistance : 0;
    bool canComplete = progress >= 0.75;
    if (progress > 0.5 && progress < 0.6) {
      HapticFeedback.lightImpact();
    } else if (progress > 0.7 && progress < 0.8) {
      HapticFeedback.mediumImpact();
    }

    emit(SwipeDragging(
      progress: progress,
      offset: _dragOffset,
      canComplete: canComplete,
    ));
  }

  void endDrag() async {
    if (_navigated || _isResetting) return;
    double progress = _maxDragDistance > 0 ? _dragOffset / _maxDragDistance : 0;
    if (progress >= 0.75) {
      await completeSwipe();
    } else {
      resetSwipe();
    }
  }

  Future<void> completeSwipe() async {
    if (_navigated || _isResetting) return;
    _navigated = true;
    emit(SwipeCompleting());
    HapticFeedback.heavyImpact();
    await Future.delayed(const Duration(milliseconds: 300));
    if (!isClosed) {
      emit(SwipeCompleted());
    }
  }

  void resetSwipe() {
    if (_isResetting) return;
    _isResetting = true;
    _dragOffset = 0.0;
    emit(SwipeReset());
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!isClosed) {
        _isResetting = false;
        emit(SwipeInitial());
      }
    });
  }

  void reset() {
    _dragOffset = 0.0;
    _navigated = false;
    _isResetting = false;
    if (!isClosed) {
      emit(SwipeInitial());
    }
  }

  void fullReset() {
    _dragOffset = 0.0;
    _navigated = false;
    _isResetting = false;
    _maxDragDistance = 0.0;
    if (!isClosed) {
      emit(SwipeInitial());
    }
  }

  bool get hasNavigated => _navigated;
  bool get isResetting => _isResetting;
}
