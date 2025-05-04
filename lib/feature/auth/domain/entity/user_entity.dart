enum UserRole { captain, passenger }

enum VehicleType { privateCar, microbus, minibus, bus, motorcycle }

class UserEntity {
  final String id;
  final String? firstName;
  final String? lastName;
  final String? city;
  final String phoneNumber;
  final String? email;
  final UserRole? role;
  final VehicleType? vehicleType;
  final int? seatCount;
  final bool isEmailVerified;
  final double? latitude;
  final double? longitude;
  final String? locationName;

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
    this.latitude,
    this.longitude,
    this.locationName,
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
    double? latitude,
    double? longitude,
    String? locationName,
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
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      locationName: locationName ?? this.locationName,
    );
  }
}
