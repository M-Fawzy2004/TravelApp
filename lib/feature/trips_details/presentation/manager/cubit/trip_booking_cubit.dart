import 'package:flutter_bloc/flutter_bloc.dart';
import 'trip_booking_state.dart';

class TripBookingCubit extends Cubit<TripBookingState> {
  TripBookingCubit()
      : super(
          TripBookingState(
            counter: 1,
            isFavorite: false,
          ),
        );

  void incrementCounter() {
    emit(state.copyWith(counter: state.counter + 1));
  }

  void decrementCounter() {
    if (state.counter > 1) {
      emit(state.copyWith(counter: state.counter - 1));
    }
  }

  void toggleFavorite() {
    emit(state.copyWith(isFavorite: !state.isFavorite));
  }

  void updateBookingNotes(String notes) {
    emit(state.copyWith(bookingNotes: notes));
  }
}
