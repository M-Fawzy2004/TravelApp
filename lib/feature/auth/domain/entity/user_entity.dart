import 'package:equatable/equatable.dart';

enum UserRole { captain, directDelivery, passenger }

enum VehicleType { privateCar, microbus, minibus, bus, motorcycle }

class UserEntity extends Equatable {
  final String id;
  final String? firstName;
  final String? lastName;
  final String? city;
  final String phoneNumber;
  final String? email;
  final UserRole? role;
  final VehicleType? vehicleType;
  final int? seatCount;
  final String? vehicleBrand;
  final String? vehicleModel;
  final String? vehicleLicense;
  final bool isEmailVerified;
  final double? latitude;
  final double? longitude;
  final String? locationName;

  const UserEntity({
    required this.id,
    this.firstName,
    this.lastName,
    this.city,
    required this.phoneNumber,
    this.email,
    this.role,
    this.vehicleType,
    this.seatCount,
    this.vehicleBrand,
    this.vehicleModel,
    this.vehicleLicense,
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
    String? vehicleBrand,
    String? vehicleModel,
    String? vehicleLicense,
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
      vehicleBrand: vehicleBrand ?? this.vehicleBrand,
      vehicleModel: vehicleModel ?? this.vehicleModel,
      vehicleLicense: vehicleLicense ?? this.vehicleLicense,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      locationName: locationName ?? this.locationName,
    );
  }

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        city,
        phoneNumber,
        email,
        role,
        vehicleType,
        seatCount,
        vehicleBrand,
        vehicleModel,
        vehicleLicense,
        isEmailVerified,
        latitude,
        longitude,
        locationName,
      ];
}
