class TripBookingState {
  final int counter;
  final bool isFavorite;
  final String? bookingNotes;

  TripBookingState({
    required this.counter,
    required this.isFavorite,
    this.bookingNotes,
  });

  TripBookingState copyWith({
    int? counter,
    bool? isFavorite,
    String? bookingNotes,
  }) {
    return TripBookingState(
      counter: counter ?? this.counter,
      isFavorite: isFavorite ?? this.isFavorite,
      bookingNotes: bookingNotes ?? this.bookingNotes,
    );
  }
}
