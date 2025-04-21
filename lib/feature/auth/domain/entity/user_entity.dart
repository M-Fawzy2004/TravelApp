enum UserRole { captain, passenger }

enum VehicleType { privateCar, microbus, minibus, bus, motorcycle }

class UserEntity {
  final String id;
  final String? firstName;
  final String? lastName;
  final String? city;
  final String phoneNumber;
  final String? email;
  final UserRole? role; // captain, passenger
  final VehicleType?
      vehicleType; // privateCar, microbus, minibus, bus, motorcycle
  final int? seatCount; // number of seats
  final bool isEmailVerified;

  UserEntity({
    required this.id,
    this.firstName,
    this.lastName,
    this.city,
    required this.phoneNumber,
    this.email,
    this.role,
    this.vehicleType,
    this.seatCount,
    this.isEmailVerified = false,
  });

  UserEntity copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? city,
    String? phoneNumber,
    String? email,
    UserRole? role,
    VehicleType? vehicleType,
    int? seatCount,
    bool? isEmailVerified,
  }) {
    return UserEntity(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      city: city ?? this.city,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      role: role ?? this.role,
      vehicleType: vehicleType ?? this.vehicleType,
      seatCount: seatCount ?? this.seatCount,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
    );
  }
}
