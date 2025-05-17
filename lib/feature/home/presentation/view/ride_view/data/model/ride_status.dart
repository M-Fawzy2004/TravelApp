enum RideStatus {
  pending,
  accepted,
  ongoing,
  completed,
  cancelled,
}

extension RideStatusExtension on RideStatus {
  String toShortString() => toString().split('.').last;

  static RideStatus fromString(String status) {
    return RideStatus.values.firstWhere(
      (e) => e.toShortString() == status,
      orElse: () => RideStatus.pending,
    );
  }
}
